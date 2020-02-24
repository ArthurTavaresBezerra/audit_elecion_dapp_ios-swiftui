package blockchain.breizhcamp.attendeesdapp;

import android.util.Log;

import rx.Observer;

/**
 * Created by gunicolas on 28/03/17.
 */

public class LogObserver<T> implements Observer<T> {

    @Override
    public void onCompleted() {
        Log.i(getClass().getSimpleName(),"COMPLETE");
    }

    @Override
    public void onError(Throwable e) {
        Log.e(getClass().getSimpleName(),"ERROR : "+e.getMessage());
    }

    @Override
    public void onNext(T t) {
        Log.d(getClass().getSimpleName(),"NEXT : "+t.toString());
    }
}
