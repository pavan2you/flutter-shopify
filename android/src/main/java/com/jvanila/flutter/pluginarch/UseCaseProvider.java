package com.jvanila.flutter.pluginarch;

import android.content.Context;
import android.os.Handler;

import com.jvanila.flutter.api.Api;

import java.lang.reflect.Constructor;
import java.lang.reflect.InvocationTargetException;
import java.util.HashMap;
import java.util.Objects;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

//import com.jvanila.flutter.shopify.Api;

/**
 * Created by pavan on 23/09/18
 */
public class UseCaseProvider<I extends MethodCall, O extends MethodChannel.Result, T> {

    private Context mContext;
    private Api<T> mApi;
    private Handler mExecutor;

    private HashMap<String, UseCase<I, O, T>> mLookup;

    UseCaseProvider(Context context, Api<T> api, Handler executor) {
        mContext = context;
        mApi = api;
        mExecutor = executor;

        mLookup = new HashMap<>();
    }

    public void register(String methodIdentifier, Class<? extends UseCase<I, O, T>> useCaseClass) {
        register(methodIdentifier, newUseCase(useCaseClass));
    }

    public void register(String methodIdentifier, UseCase<I, O, T> useCase) {
        mLookup.put(methodIdentifier, useCase);
    }

    private UseCase<I, O, T> newUseCase(Class<? extends UseCase<I, O, T>> useCaseClass) {
        UseCase<I, O, T> useCase = null;

        Constructor<?>[] constructors = useCaseClass.getConstructors();
        Constructor<?> foundConstructor = null;

        for (Constructor<?> constructor : constructors) {
            Class<?>[] parameterTypes = constructor.getParameterTypes();

            boolean found = false;
            for (Class<?> parameterType : parameterTypes) {

                if (!parameterType.isAssignableFrom(Context.class)) {
                    continue;
                }
                if (!parameterType.isAssignableFrom(Api.class)) {
                    continue;
                }
                if (!parameterType.isAssignableFrom(Handler.class)) {
                    continue;
                }

                found = true;
            }

            if (found) {
                foundConstructor = constructor;
                break;
            }
        }

        try {
            useCase = useCaseClass.cast(Objects.requireNonNull(
                    foundConstructor).newInstance(mContext, mApi, mExecutor));
        }
        catch (InstantiationException | IllegalAccessException | InvocationTargetException e) {
            e.printStackTrace();
        }

        return useCase;
    }

    public UseCase<I, O, T> of(String methodIdentifier) {
        return mLookup.get(methodIdentifier);
    }
}
