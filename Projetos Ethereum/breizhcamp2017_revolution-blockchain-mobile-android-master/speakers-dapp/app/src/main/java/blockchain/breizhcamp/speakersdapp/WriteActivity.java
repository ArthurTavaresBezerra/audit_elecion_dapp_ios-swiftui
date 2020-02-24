package blockchain.breizhcamp.speakersdapp;

import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.text.Editable;
import android.text.TextWatcher;
import android.util.Log;
import android.widget.EditText;
import android.widget.ProgressBar;

import com.dd.CircularProgressButton;
import com.sqli.blockchain.android_geth.EthereumService;

import ethereumjava.exception.EthereumJavaException;
import ethereumjava.module.objects.TransactionRequest;
import ethereumjava.solidity.SolidityUtils;
import rx.Observable;
import rx.android.schedulers.AndroidSchedulers;

public class WriteActivity extends AppCompatActivity implements EthereumService.EthereumServiceInterface{

    private static final int COMPLETE_STATE = 100;
    private static final int IDLE_STATE = 0;
    private static final int ERROR_STATE = -1;

    private static final String LOG_ID = WriteActivity.class.getSimpleName();

    ProgressBar progressBar;
    MyApplication application;
    CircularProgressButton sendMessageButton;
    EditText messageEdittext;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.write_layout);

        application = (MyApplication) getApplication();
        application.registerGethReady(this);

        progressBar = (ProgressBar) findViewById(R.id.write_loading);
        progressBar.setIndeterminate(true);
        progressBar.setVisibility(ProgressBar.VISIBLE);

        progressBar.getIndeterminateDrawable().setColorFilter(
                getResources().getColor(R.color.colorPrimary),
                android.graphics.PorterDuff.Mode.SRC_IN);

        sendMessageButton = (CircularProgressButton) findViewById(R.id.send_message_button);
        sendMessageButton.setEnabled(false);
        sendMessageButton.setOnClickListener(v -> sendButtonClicked());
        messageEdittext = (EditText) findViewById(R.id.message_edittext);

        messageEdittext.addTextChangedListener(new MessageTextWatcher());

    }

    private void sendButtonClicked(){
        switch (sendMessageButton.getProgress()) {
            case ERROR_STATE:
                sendMessageButton.setProgress(IDLE_STATE);
                break;
            case IDLE_STATE:
                sendMessage(messageEdittext.getText().toString());
                sendMessageButton.setProgress(COMPLETE_STATE);
                break;
            case COMPLETE_STATE:
                sendMessageButton.setProgress(IDLE_STATE);
                break;
            default:
                break;
        }
    }

    private void sendMessage(String message){
        String account = application.ethereumjava.personal.listAccounts().get(0);
        TransactionRequest tx = new TransactionRequest(account,account);
        tx.setDataHex(SolidityUtils.toHex(message));
        application.ethereumjava.eth.sendTransaction(tx);
    }

    class MessageTextWatcher implements TextWatcher{

        @Override
        public void beforeTextChanged(CharSequence s, int start, int count, int after) {

        }

        @Override
        public void onTextChanged(CharSequence s, int start, int before, int count) {
            boolean enabled = false;
            if( s.length() > 0 ){
                enabled = true;
            }
            sendMessageButton.setEnabled(enabled);
            Log.d("APP","ENABLED : "+enabled);
        }

        @Override
        public void afterTextChanged(Editable s) {

        }
    }

    @Override
    public void onEthereumServiceReady() {

            Observable.just(true)
                .observeOn(AndroidSchedulers.mainThread())
                .subscribe(b -> progressBar.setVisibility(ProgressBar.INVISIBLE));


    }



}
