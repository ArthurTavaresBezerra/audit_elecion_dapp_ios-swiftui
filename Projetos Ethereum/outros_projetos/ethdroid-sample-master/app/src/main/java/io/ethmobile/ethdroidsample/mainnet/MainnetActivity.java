package io.ethmobile.ethdroidsample.mainnet;

import android.support.v7.app.AppCompatActivity;

import io.ethmobile.ethdroid.EthDroid;
import io.ethmobile.ethdroidsample.R;

/**
 * Created by gunicolas on 31/05/17.
 */

public class MainnetActivity extends AppCompatActivity {


    @Override
    protected void onStart() {
        super.onStart();
        setContentView(R.layout.activity_mainnet);

        String datadir = getFilesDir().getAbsolutePath();

        try {
            new EthDroid.Builder(datadir)
                    .onMainnet()
                    .build()
                    .start();




        } catch (Exception e) {
            e.printStackTrace();
        }


    }
}
