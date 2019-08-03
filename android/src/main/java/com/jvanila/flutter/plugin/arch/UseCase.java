package com.jvanila.flutter.plugin.arch;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

/**
 * Created by pavan on 22/09/18
 */
public abstract class UseCase<I extends MethodCall, O extends MethodChannel.Result, T> {

    protected final PluginContext<T> mPluginContext;
    protected Runnable mLastExecution;

    public UseCase(PluginContext<T> pluginContext) {
        mPluginContext = pluginContext;
    }

    public void execute(final I input, final O result) {
        if (!canExecute(input)) {
            result.error(this.getClass().getSimpleName(), "Either input or arguments are null",
                    null);
            return;
        }

        dispose();
        mLastExecution = buildRunnableUseCase(input, result);
        mPluginContext.executor.post(mLastExecution);
    }

    private boolean canExecute(I input) {
        return !PluginContext.isDirty(mPluginContext) && input != null;
    }

    private Runnable buildRunnableUseCase(final I input, final O result) {
        return () -> call(input, result);
    }

    protected abstract void call(I input, O result);

    public void dispose() {
        if (mLastExecution != null) {
            mPluginContext.executor.removeCallbacks(mLastExecution);
            mLastExecution = null;
        }
    }
}
