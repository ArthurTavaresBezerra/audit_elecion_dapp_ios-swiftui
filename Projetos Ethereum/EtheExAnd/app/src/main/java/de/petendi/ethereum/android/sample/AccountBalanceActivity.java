package de.petendi.ethereum.android.sample;

import android.animation.Animator;
import android.animation.AnimatorListenerAdapter;
import android.annotation.TargetApi;
import android.os.AsyncTask;
import android.os.Build;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.text.TextUtils;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.AutoCompleteTextView;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;

import java.lang.reflect.Field;

import de.petendi.ethereum.android.EthereumAndroid;
import de.petendi.ethereum.android.EthereumAndroidCallback;
import de.petendi.ethereum.android.EthereumAndroidFactory;
import de.petendi.ethereum.android.EthereumNotInstalledException;
import de.petendi.ethereum.android.Utils;
import de.petendi.ethereum.android.service.model.RpcCommand;
import de.petendi.ethereum.android.service.model.ServiceError;
import de.petendi.ethereum.android.service.model.WrappedRequest;
import de.petendi.ethereum.android.service.model.WrappedResponse;

public class AccountBalanceActivity extends AppCompatActivity implements EthereumAndroidCallback {

    private class MyAsyncTask extends AsyncTask<Void,Void,WrappedResponse> {
        private final WrappedRequest request;

        private MyAsyncTask(WrappedRequest request) {
            this.request = request;
        }


        @Override
        protected WrappedResponse doInBackground(Void... voids) {
            return ethereumAndroid.send(request);
        }

        @Override
        protected void onPostExecute(final WrappedResponse wrappedResponse) {
            showResponse(wrappedResponse);
        }
    }

    private AutoCompleteTextView accountInput;
    private View progressView;
    private View formView;

    private EthereumAndroid ethereumAndroid;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        //this is a hack to disable the signature check so that it also connects
        //to development versions of Ethereum Android
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
        setContentView(R.layout.activity_main);
        accountInput = (AutoCompleteTextView) findViewById(R.id.address_input);
        Button requestButton = (Button) findViewById(R.id.request_account);
        requestButton.setOnClickListener(new OnClickListener() {
            @Override
            public void onClick(View view) {
                request();
            }
        });
        Button requestSyncButton = (Button) findViewById(R.id.request_account_sync);
        requestSyncButton.setOnClickListener(new OnClickListener() {
            @Override
            public void onClick(View view) {
                requestSync();
            }
        });
        formView = findViewById(R.id.form);
        progressView = findViewById(R.id.progress);
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        if(ethereumAndroid!=null) {
            ethereumAndroid.release();
        }
    }

    private void request() {

        accountInput.setError(null);
        String accountAddress = accountInput.getText().toString();
        boolean cancel = false;
        View focusView = null;
        if (TextUtils.isEmpty(accountAddress)) {
            accountInput.setError(getString(R.string.error_field_required));
            focusView = accountInput;
            cancel = true;
        }
        if (cancel) {
            focusView.requestFocus();
        } else {
            showProgress(true);
            WrappedRequest wrappedRequest = new WrappedRequest();
            wrappedRequest.setCommand(RpcCommand.eth_getBalance.toString());
            wrappedRequest.setParameters(new String[]{accountAddress, "latest"});
            ethereumAndroid.sendAsync(wrappedRequest);
        }
    }

    private void requestSync() {

        accountInput.setError(null);
        String accountAddress = accountInput.getText().toString();
        boolean cancel = false;
        View focusView = null;
        if (TextUtils.isEmpty(accountAddress)) {
            accountInput.setError(getString(R.string.error_field_required));
            focusView = accountInput;
            cancel = true;
        }
        if (cancel) {
            focusView.requestFocus();
        } else {
            showProgress(true);
            WrappedRequest wrappedRequest = new WrappedRequest();
            wrappedRequest.setCommand(RpcCommand.eth_getBalance.toString());
            wrappedRequest.setParameters(new String[]{accountAddress, "latest"});
            new MyAsyncTask(wrappedRequest).execute();
        }
    }


    @TargetApi(Build.VERSION_CODES.HONEYCOMB_MR2)
    private void showProgress(final boolean show) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.HONEYCOMB_MR2) {
            int shortAnimTime = getResources().getInteger(android.R.integer.config_shortAnimTime);

            formView.setVisibility(show ? View.GONE : View.VISIBLE);
            formView.animate().setDuration(shortAnimTime).alpha(
                    show ? 0 : 1).setListener(new AnimatorListenerAdapter() {
                @Override
                public void onAnimationEnd(Animator animation) {
                    formView.setVisibility(show ? View.GONE : View.VISIBLE);
                }
            });

            progressView.setVisibility(show ? View.VISIBLE : View.GONE);
            progressView.animate().setDuration(shortAnimTime).alpha(
                    show ? 1 : 0).setListener(new AnimatorListenerAdapter() {
                @Override
                public void onAnimationEnd(Animator animation) {
                    progressView.setVisibility(show ? View.VISIBLE : View.GONE);
                }
            });
        } else {
            progressView.setVisibility(show ? View.VISIBLE : View.GONE);
            formView.setVisibility(show ? View.GONE : View.VISIBLE);
        }
    }


    @Override
    public void handleResponse(int i, final WrappedResponse response) {
        Runnable updateUiTask = new Runnable() {
            @Override
            public void run() {
                showResponse(response);
            }
        };
        runOnUiThread(updateUiTask);

    }

    private void showResponse(final WrappedResponse response) {
        showProgress(false);
        TextView balanceTextView = (TextView) findViewById(R.id.account_balance);
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
                showProgress(false);
                TextView balanceTextView = (TextView) findViewById(R.id.account_balance);
                String errorMsg = getString(R.string.error_occured);
                balanceTextView.setText(errorMsg + " " + error.getErrorMessage());
            }
        };
        runOnUiThread(updateUiTask);
    }


}

