package io.ethmobile.ethdroidsample.private_chain;

import android.content.Context;
import android.os.Build;
import android.support.v7.app.AlertDialog;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.Button;

import org.ethereum.geth.Account;

import java.io.File;

import io.ethmobile.ethdroid.ChainConfig;
import io.ethmobile.ethdroid.EthDroid;
import io.ethmobile.ethdroid.KeyManager;
import io.ethmobile.ethdroid.solidity.types.SUInt;
import io.ethmobile.ethdroidsample.ITestContract;
import io.ethmobile.ethdroidsample.Log;
import io.ethmobile.ethdroidsample.R;
import rx.android.schedulers.AndroidSchedulers;

import static io.ethmobile.ethdroid.Utils.deleteDirIfExists;

public class PrivateChainActivity extends AppCompatActivity implements View.OnClickListener {

    Button sendMoneyButton;
    Button sendTxSCButton;
    Button callTxButton;
    Button sendTxNotifButton;

    private EthDroid ethdroid;
    private KeyManager keyManager;
    private Account account;
    private static final String PASSWORD = "password";
    private ITestContract contract;

    @Override
    protected void onStart() {
        super.onStart();
        setContentView(R.layout.activity_privatechain);

        sendMoneyButton = (Button) findViewById(R.id.sendmoney_button);
        sendTxSCButton = (Button) findViewById(R.id.sendTx_SC_button);
        callTxButton = (Button) findViewById(R.id.callSC_button);
        sendTxNotifButton = (Button) findViewById(R.id.sendTx_notif_button);
        sendMoneyButton.setOnClickListener(this);
        sendTxSCButton.setOnClickListener(this);
        callTxButton.setOnClickListener(this);
        sendTxNotifButton.setOnClickListener(this);

        String datadir = getFilesDir().getAbsolutePath();

        deleteDirIfExists(new File(datadir + "/GethDroid"));
        deleteDirIfExists(new File(datadir + "/keystore"));

        long networkID = 100;
        String genesis = "{ \n" +
                "\t\"config\": {\n" +
                "\t\t\"chainId\": 100,\n" +
                "\t\t\"homesteadBlock\": 0,\n" +
                "\t\t\"eip155Block\": 0,\n" +
                "\t\t\"eip158Block\": 0\n" +
                "\t},\n" +
                "\t\"nonce\": \"0x0000000000000042\", \n" +
                "\t\"timestamp\": \"0x0\", \n" +
                "\t\"parentHash\": \"0x0000000000000000000000000000000000000000000000000000000000000000\", \n" +
                "\t\"extraData\": \"\", \n" +
                "\t\"gasLimit\": \"0x8000000\", \n" +
                "\t\"difficulty\": \"0x100\", \n" +
                "\t\"mixhash\": \"0x0000000000000000000000000000000000000000000000000000000000000000\", \n" +
                "\t\"coinbase\": \"0x0000000000000000000000000000000000000042\", \n" +
                "\t\"alloc\": { \n" +
                "\n" +
                "\t} \n" +
                "}\n";
        String enode = "enode://a448517e9e7c6ae984c040791573b7e7b383461e34f546136e5e8ee8c3a4a61f8ee8f6836cb35a0b9e7de88bfaf5f01e528639a61357ab81f5fa8c5bc5e6a412@10.33.44.51:30301?discport:30302";

        try {
            keyManager = KeyManager.newKeyManager(datadir);
            account = keyManager.newUnlockedAccount(PASSWORD);
            //account = keyManager.getAccounts().get(0);
            //keyManager.unlockAccount(account,PASSWORD);

            Log.print(account.getAddress().getHex());

            ethdroid = new EthDroid.Builder(datadir)
                    .withChainConfig(new ChainConfig.Builder(networkID, genesis, enode).build())
                    .withKeyManager(keyManager)
                    .build();

            ethdroid.start();

            ethdroid.newHeadFilter().subscribe(header -> Log.print(header.getHash().getHex()));

            /*contract = ethdroid.getContractInstance(ITestContract.class,"0x06ad6dfb208e82a11dc244815498461ba21727af");


            contract.simpleEvent().listen()
                .subscribe(event -> Log.print(event.getElement1().asString()));
*/
        } catch (Exception e) {
            Log.print(e.getMessage());
        }
    }

    @Override
    public void onClick(View v) {
        try {
            if (v == sendMoneyButton) {
                ethdroid.newTransaction()
                        .to(account.getAddress())
                        .value(30)
                        .send();
            } else if (v == sendTxSCButton) {
                contract.bar(SUInt.SUInt8.fromShort((short) 3)).send();
            } else if (v == callTxButton) {
                Log.print(contract.value().call().getElement1().asString());
            } else if (v == sendTxNotifButton) {
                ethdroid.newTransaction()
                        .to(account.getAddress())
                        .value(0)
                        .sendWithNotification()
                        .observeOn(AndroidSchedulers.mainThread())
                        .subscribe(block -> showDialog(PrivateChainActivity.this,
                                "Transaction successfully mined in block n°" + block.getNumber()),
                                error -> showDialog(PrivateChainActivity.this,
                                        error.getMessage()));
            }
        } catch (Exception e) {
            Log.print(e.getMessage());
        }

    }

    @Override
    protected void onStop() {
        try {
            ethdroid.stop();
        } catch (Exception e) {
            Log.print(e.getMessage());
        }
        super.onStop();
    }


    private static void showDialog(Context context, String message) {
        AlertDialog.Builder builder;
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            builder = new AlertDialog.Builder(context, android.R.style.Theme_Material_Dialog_Alert);
        } else {
            builder = new AlertDialog.Builder(context);
        }
        builder.setTitle("Success")
                .setMessage(message)
                .setNeutralButton(android.R.string.ok, (dialog, which) -> dialog.dismiss())
                .setIcon(android.R.drawable.ic_dialog_alert)
                .show();
    }

}
