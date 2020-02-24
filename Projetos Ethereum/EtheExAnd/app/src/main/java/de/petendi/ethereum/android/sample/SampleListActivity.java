package de.petendi.ethereum.android.sample;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;

import java.lang.reflect.Field;

import de.petendi.ethereum.android.EthereumAndroid;
import de.petendi.ethereum.android.EthereumAndroidCallback;
import de.petendi.ethereum.android.EthereumAndroidFactory;
import de.petendi.ethereum.android.EthereumNotInstalledException;
import de.petendi.ethereum.android.Utils;
import de.petendi.ethereum.android.service.model.ServiceError;
import de.petendi.ethereum.android.service.model.WrappedResponse;

public class SampleListActivity extends AppCompatActivity implements EthereumAndroidCallback {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_sample_list);
        setButtons();
    }

    private void setButtons() {

        final View.OnClickListener clickListener = new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                int id = v.getId();
                Class<? extends Activity> activityClass;
                switch (id) {
                    case R.id.sample_account_balance_button:
                        activityClass = AccountBalanceActivity.class;

                        break;
                    case R.id.sample_simplestorage_button:
                        activityClass = SimpleStorageActivity.class;
                        break;
                    default:
                        throw new IllegalArgumentException("unknown button: " + id);

                }
                Intent intent = new Intent(SampleListActivity.this, activityClass);
                SampleListActivity.this.startActivity(intent);
            }
        };
        ViewGroup parent = (ViewGroup) findViewById(R.id.samplelist_layout);
        for (int i = 0; i < parent.getChildCount(); i++) {
            View view = parent.getChildAt(i);
            if (view instanceof Button) {
                Button button = (Button) view;
                button.setOnClickListener(clickListener);

            }
        }

    }


    private void testeEthereum(){
        EthereumAndroid ethereumAndroid = null;
        try {
            Field devField = EthereumAndroidFactory.class.getDeclaredField("DEV");
            devField.setAccessible(true);
            devField.set(null,true);
        } catch (NoSuchFieldException e) {
            e.printStackTrace();
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        }
        EthereumAndroidFactory ethereumAndroidFactory = new EthereumAndroidFactory(this);
        try {
            ethereumAndroid = ethereumAndroidFactory.create(this);
        } catch (EthereumNotInstalledException e) {
            Toast.makeText(this,R.string.ethereum_ethereum_not_installed,Toast.LENGTH_LONG).show();
            ethereumAndroidFactory.showInstallationDialog();
            //finish();
        }
    }

    @Override
    public void handleResponse(int messageId, WrappedResponse response) {
        TextView balanceTextView = (TextView) findViewById(R.id.sample_list_txt);
        if(response.isSuccess()) {
            String balance = getString(R.string.balance);
            balanceTextView.setText(balance + " " + Utils.fromHexString((String)response.getResponse()));
        } else {
            balanceTextView.setText(response.getErrorMessage());
        }
    }

    @Override
    public void handleError(int i, final ServiceError error) {
        Runnable updateUiTask = new Runnable() {
            @Override
            public void run() {
                //showProgress(false);
                TextView balanceTextView = (TextView) findViewById(R.id.sample_list_txt);
                String errorMsg = getString(R.string.error_occured);
                balanceTextView.setText(errorMsg + " " + error.getErrorMessage());
            }
        };
        runOnUiThread(updateUiTask);
    }
}
