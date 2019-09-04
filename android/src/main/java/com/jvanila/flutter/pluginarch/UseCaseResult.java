package com.jvanila.flutter.pluginarch;

import android.os.Handler;

import io.flutter.plugin.common.MethodChannel;

/**
 * Created by pavan on 22/09/18
 */
public class UseCaseResult implements MethodChannel.Result {

    private final Handler mCallerHandler;
    private final MethodChannel.Result mResult;

    UseCaseResult(Handler callerHandler, MethodChannel.Result result) {
        this.mCallerHandler = callerHandler;
        this.mResult = result;
    }

    /*
     * Make sure to respond in the caller thread
     */
    public void success(final Object results) {
        mCallerHandler.post(new Runnable() {
                                @Override
                                public void run() {
                                    mResult.success(results);

                                }
                            }
        );
    }

    public void error(final String errorCode, final String errorMessage, final Object data) {
        mCallerHandler.post(new Runnable() {
            @Override
            public void run() {
                mResult.error(errorCode, errorMessage, "{error : "+data+"}");

            }
        });
    }

    @Override
    public void notImplemented() {
        mCallerHandler.post(new Runnable() {
            @Override
            public void run() {
                mResult.notImplemented();

            }
        });
    }
}
