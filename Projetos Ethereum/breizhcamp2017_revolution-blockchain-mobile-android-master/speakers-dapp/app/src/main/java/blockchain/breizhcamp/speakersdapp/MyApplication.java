package blockchain.breizhcamp.speakersdapp;

import android.util.Log;

import com.sqli.blockchain.android_geth.EthereumApplication;

import java.util.List;

import ethereumjava.EthereumJava;
import ethereumjava.net.provider.AndroidIpcProvider;

/**
 * Created by gunicolas on 27/03/17.
 */

public class MyApplication extends EthereumApplication {

    private static final String LOG_ID = MyApplication.class.getSimpleName();

    public EthereumJava ethereumjava;

    @Override
    public void onEthereumServiceReady() {
        ethereumjava = new EthereumJava.Builder()
                .provider(new AndroidIpcProvider(ethereumService.getIpcFilePath()))
                .build();

        for(String peer : Constants.BOOTNODES_ID){
            boolean added = ethereumjava.admin.addPeer(peer);
            Log.d(LOG_ID,"PEER : "+added);
        }

        Log.d(LOG_ID,"ENODE : "+ethereumjava.admin.nodeInfo().enode);

        List<String> accounts = ethereumjava.personal.listAccounts();
        String account;
        if( accounts.size() == 0 ) {
            String accountId = ethereumjava.personal.newAccount("PASSWD");
            account = accountId;
        } else{
            account = accounts.get(0);
        }
        Log.d(LOG_ID,"ACCOUNT : "+account);

        ethereumjava.personal.unlockAccount(account,"PASSWD",0);

        super.onEthereumServiceReady();
    }

    @Override
    protected boolean isResetDatadir() {
        return true;
    }
}
