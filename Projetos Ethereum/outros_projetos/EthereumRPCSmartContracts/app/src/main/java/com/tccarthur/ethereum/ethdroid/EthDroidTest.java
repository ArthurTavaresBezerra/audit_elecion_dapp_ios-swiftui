package com.tccarthur.ethereum.ethdroid;

import android.content.Context;

import java.io.File;
import java.util.concurrent.TimeUnit;

import io.ethmobile.ethdroid.ChainConfig;
import io.ethmobile.ethdroid.EthDroid;

import static io.ethmobile.ethdroid.Utils.deleteDirIfExists;

/**
 * Created by gunicolas on 16/05/17.
 */

public class EthDroidTest {

    private Context appContext;
    private EthDroid ethdroid;


    public void setUp(Context appContext) throws Exception {
        this.appContext = appContext;
        String datadir = appContext.getFilesDir().getAbsolutePath();

        deleteDirIfExists(new File(datadir + "/GethDroid"));

        long networkID = 100;
        String genesis =
            "{\"config\": {\"chainId\": 100, \"homesteadBlock\": 0, \"eip155Block\": 0, "
                + "\"eip158Block\": 0 }, \"nonce\": \"0x0000000000000042\", \"timestamp\": "
                + "\"0x0\", \"parentHash\": "
                + "\"0x0000000000000000000000000000000000000000000000000000000000000000\", "
                + "\"extraData\": \"\", \"gasLimit\": \"0x8000000\", \"difficulty\": \"0x100\", "
                + "\"mixhash\": "
                + "\"0x0000000000000000000000000000000000000000000000000000000000000000\", "
                + "\"coinbase\": \"0x0000000000000000000000000000000000000042\", \"alloc\": {} }";
        String enode =
            "enode://a448517e9e7c6ae984c040791573b7e7b383461e34f546136e5e8ee8c3a4a61f8ee8f6836cb35a0b9e7de88bfaf5f01e528639a61357ab81f5fa8c5bc5e6a412@10.33.44.111:30301?discport:30302";

        ethdroid = new EthDroid.Builder(datadir)
            .withChainConfig(new ChainConfig.Builder(networkID, genesis, enode).build())
            .build();

        ethdroid.start();
    }

    public void isSyncingTest() {
        //assertFalse(ethdroid.isSyncing());
    }

    //@Test
    public void isSynced() throws Exception {
        TimeUnit.SECONDS.sleep(5);
        //assertTrue(ethdroid.isSynced());
    }
}
