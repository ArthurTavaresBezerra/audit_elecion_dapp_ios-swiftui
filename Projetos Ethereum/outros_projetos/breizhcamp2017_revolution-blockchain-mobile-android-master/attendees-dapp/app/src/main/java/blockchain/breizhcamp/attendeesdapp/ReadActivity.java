package blockchain.breizhcamp.attendeesdapp;

import android.media.MediaPlayer;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import android.widget.ProgressBar;
import android.widget.TextView;

import com.sqli.blockchain.android_geth.EthereumService;

import ethereumjava.module.objects.BlockFilter;
import ethereumjava.module.objects.Hash;
import ethereumjava.module.objects.Transaction;
import ethereumjava.solidity.SolidityUtils;
import rx.Observable;
import rx.android.schedulers.AndroidSchedulers;

public class ReadActivity extends AppCompatActivity implements EthereumService.EthereumServiceInterface{

    ProgressBar progressBar;
    MyApplication application;
    TextView lastMsgView;
    MediaPlayer player;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.read_layout);

        application = (MyApplication) getApplication();
        application.registerGethReady(this);

        progressBar = (ProgressBar) findViewById(R.id.read_loading);
        progressBar.setIndeterminate(true);
        progressBar.setVisibility(ProgressBar.VISIBLE);

        lastMsgView = (TextView) findViewById(R.id.last_message_view);
        player = MediaPlayer.create(this,R.raw.alert);

    }

    @Override
    protected void onResume() {
        super.onResume();
        progressBar.setVisibility(ProgressBar.INVISIBLE);
    }

    @Override
    public void onEthereumServiceReady() {

            Observable.just(true)
                    .observeOn(AndroidSchedulers.mainThread())
                    .subscribe(b -> progressBar.setVisibility(ProgressBar.INVISIBLE));


            new BlockFilter(application.ethereumjava.eth).watch()
                    // Observable<Block<Hash>>
                    .flatMap(blockHash ->
                            application.ethereumjava.eth.getBlock(
                                    Hash.valueOf(blockHash), Transaction.class
                            )
                    )


                    // Observable<Transaction>
                    .flatMap(block -> Observable.from(block.transactions))


                    // Observable<Transaction>
                    .filter(transaction ->
                        return transaction.input != null && transaction.input.length() > 2
                    )


                    .observeOn(AndroidSchedulers.mainThread())


                    .subscribe(transaction -> {
                        Log.d(ReadActivity.class.getSimpleName(), "CONTENT : "+transaction.input);

                        lastMsgView.setText(SolidityUtils.hexToAscii(transaction.input));

                        player.start();
                    });

    }



}
