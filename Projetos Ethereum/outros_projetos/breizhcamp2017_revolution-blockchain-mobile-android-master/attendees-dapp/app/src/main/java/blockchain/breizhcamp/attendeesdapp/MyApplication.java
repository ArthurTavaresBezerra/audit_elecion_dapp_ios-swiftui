package blockchain.breizhcamp.attendeesdapp;

import android.util.Log;

import com.sqli.blockchain.android_geth.EthereumApplication;

import ethereumjava.EthereumJava;
import ethereumjava.net.provider.AndroidIpcProvider;

/**
 * Created by gunicolas on 27/03/17.
 */

public class MyApplication extends EthereumApplication {

    public EthereumJava ethereumjava;

    @Override
    public void onEthereumServiceReady() {
        ethereumjava = new EthereumJava.Builder()
                .provider(new AndroidIpcProvider(ethereumService.getIpcFilePath()))
                .build();

        for(String peer : Constants.BOOTNODES_ID){
            boolean added = ethereumjava.admin.addPeer(peer);
            Log.d(MyApplication.class.getSimpleName(),"PEER : "+added);
        }

        Log.d(MyApplication.class.getSimpleName(),"ENODE : "+ethereumjava.admin.nodeInfo().enode);

        super.onEthereumServiceReady();
    }

}
