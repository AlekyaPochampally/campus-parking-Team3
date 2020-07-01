package edu.nwmissouri.mobile.carparking.beans.base;

import java.util.function.Consumer;
import java.util.function.Function;

public abstract class FunctionEntity<T> {

    @SuppressWarnings("unchecked")
    public T andThenWith(Consumer<T> consumer) {
        consumer.accept((T) this);
        return (T) this;
    }

    public <X> X andThenTransform(Function<T, X> mapper) {
        return mapper.apply((T) this);
    }
}
