package com.jvanila.flutter.pluginarch;

import android.os.Handler;
import android.os.HandlerThread;
//import android.support.annotation.NonNull;

import androidx.annotation.NonNull;

import com.jvanila.flutter.shopify.Api;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;

/**
 * Created by pavan on 23/09/18
 */
public abstract class Plugin<T> implements MethodChannel.MethodCallHandler {

    private final Object mApiLocker = new Object();

    private int mApiReferenceCount = -1;
    private HandlerThread mHandlerThread;
    private Handler mBgHandler;
//    private Handler mainHandler = new Handler();

    private PluginRegistry.Registrar mRegistrar;
    private MethodChannel mChannel;

    private PluginContext<T> mPluginContext;
    private UseCaseProvider<MethodCall, MethodChannel.Result, T> mUseCaseProvider;

    public Plugin(PluginRegistry.Registrar registrar, String name, Api<T> api) {
        MethodChannel channel = new MethodChannel(registrar.messenger(), name);
        channel.setMethodCallHandler(this);

        mRegistrar = registrar;
        mChannel = channel;

        onCreate(registrar, name, api);

        mPluginContext = newPluginContext(api);
        onCreateUseCases(mPluginContext, mUseCaseProvider);
        initDefaultUseCases();
    }

    /*@NonNull*/
    @NonNull
    private PluginContext<T> newPluginContext(Api<T> api) {
        PluginContext<T> pluginContext = new PluginContext<>();
        pluginContext.api = api;
        pluginContext.executor = mBgHandler;
        pluginContext.plugin = this;
        return pluginContext;
    }

    private void onCreate(PluginRegistry.Registrar registrar, String name, Api<T> api) {
        synchronized (mApiLocker) {
            if (++mApiReferenceCount == 0) {
                mHandlerThread = new HandlerThread(name);
                mHandlerThread.start();

                mBgHandler = new Handler(mHandlerThread.getLooper().getMainLooper());

                /*if (Debug.LOGV) {
                    Log.d(Constant.TAG, "starting thread" + mHandlerThread);
                }*/
            }
        }

        mUseCaseProvider = new UseCaseProvider<>(registrar.activeContext(), api, mBgHandler);
    }

    protected abstract void onCreateUseCases(PluginContext<T> pluginContext,
                                             UseCaseProvider<MethodCall, MethodChannel.Result, T> provider);

    private void initDefaultUseCases() {
        mUseCaseProvider.register("debug", new DebugPluginUseCase(
                mPluginContext));
        mUseCaseProvider.register("close", new ClosePluginUseCase(
                mPluginContext));
    }

    private void onDestroy() {
        synchronized (mApiLocker) {
            if (--mApiReferenceCount == 0) {
                /*if (Debug.LOGV) {
                    Log.d(Constant.TAG, "stopping thread" + handlerThread);
                }*/
//                mBgHandler = null;
                mBgHandler = null;
                mHandlerThread.quit();
                mHandlerThread = null;
            }
        }
    }

    @Override
    public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
        mUseCaseProvider.of(methodCall.method).execute(methodCall,
                new UseCaseResult(mPluginContext.executor, result));
    }

    public PluginRegistry.Registrar getRegistrar() {
        return mRegistrar;
    }

    public MethodChannel getChannel() {
        return mChannel;
    }

    public PluginContext<T> getPluginContext() {
        return mPluginContext;
    }


    ////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////  DEFAULT USE CASES  ///////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////

    private class DebugPluginUseCase extends UseCase<MethodCall, MethodChannel.Result, T> {

        DebugPluginUseCase(PluginContext<T> pluginContext) {
            super(pluginContext);
        }

        @Override
        protected void call(MethodCall input, MethodChannel.Result result) {
            Object on = input.arguments();
            mPluginContext.debug = Boolean.TRUE.equals(on);
        }
    }

    private class ClosePluginUseCase extends UseCase<MethodCall, MethodChannel.Result, T> {

        ClosePluginUseCase(PluginContext<T> pluginContext) {
            super(pluginContext);
        }

        @Override
        protected void call(MethodCall input, MethodChannel.Result result) {
            mPluginContext.plugin.onDestroy();
        }
    }
}
