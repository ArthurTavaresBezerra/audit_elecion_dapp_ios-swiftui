package com.tccarthur.ethereum.ethdroid;

import android.content.Context;

import java.io.File;

import io.ethmobile.ethdroid.ChainConfig;
import io.ethmobile.ethdroid.EthDroid;
import io.ethmobile.ethdroid.KeyManager;

import static io.ethmobile.ethdroid.Utils.deleteDirIfExists;

/**
 * Created by gunicolas on 16/05/17.
 */
public class EthDroidBuilderTest {

    private Context appContext;
    private String datadir;

    private EthDroid ethdroid;

    public void setUp(Context appContext) {
        this.appContext = appContext;
        datadir = appContext.getFilesDir().getAbsolutePath();
        deleteDirIfExists(new File(datadir + "/GethDroid"));
    }

    private void checkNodeBuilt() {
//        assertTrue(ethdroid != null);
        File dir = new File(datadir + "/GethDroid");
        //assertTrue(dir.exists());
        //      assertTrue(dir.isDirectory());
        //assertTrue(dir.list().length == 3);
        for (String fileName : dir.list()) {
            //      assertTrue(fileName.compareTo("LOCK") == 0 ||
            ////  fileName.compareTo("nodekey") == 0 ||
            //fileName.compareTo("lightchaindata") == 0);
        }
    }

    //    @Test
    public void builderPrivateChainTest() {
        try {
            long networkID = 100;
            String genesis =
                "{\"config\": {\"chainId\": 100, \"homesteadBlock\": 0, \"eip155Block\": 0, "
                    + "\"eip158Block\": 0 }, \"nonce\": \"0x0000000000000042\", \"timestamp\": "
                    + "\"0x0\", \"parentHash\": "
                    + "\"0x0000000000000000000000000000000000000000000000000000000000000000\", "
                    + "\"extraData\": \"\", \"gasLimit\": \"0x8000000\", \"difficulty\": "
                    + "\"0x100\", \"mixhash\": "
                    + "\"0x0000000000000000000000000000000000000000000000000000000000000000\", "
                    + "\"coinbase\": \"0x0000000000000000000000000000000000000042\", \"alloc\": "
                    + "{} }";
            String enode =
                "enode://a448517e9e7c6ae984c040791573b7e7b383461e34f546136e5e8ee8c3a4a61f8ee8f6836cb35a0b9e7de88bfaf5f01e528639a61357ab81f5fa8c5bc5e6a412@10.33.44.111:30301?discport:30302";

            ethdroid = new EthDroid.Builder(datadir)
                .withDefaultContext()
                .withChainConfig(new ChainConfig.Builder(networkID, genesis, enode).build())
                .build();

            ethdroid.start();

        } catch (Exception e) {
            //      fail("Exception thrown : " + e.getMessage());
        }
        checkNodeBuilt();
    }

    //  @Test
    public void builderMainnetTest() {
        try {
            ethdroid = new EthDroid.Builder(datadir)
                .withDefaultContext()
                .withChainConfig(ChainConfig.getMainnetConfig())
                .build();

            ethdroid.start();

        } catch (Exception e) {
            //        fail("Exception thrown : " + e.getMessage());
        }
        checkNodeBuilt();
    }

  //  @Test
    public void builderTestnetTest() {
        try {
            ethdroid = new EthDroid.Builder(datadir)
                .withDefaultContext()
                .withChainConfig(ChainConfig.getTestnetConfig())
                .build();

            ethdroid.start();

        } catch (Exception e) {
//            fail("Exception thrown : " + e.getMessage());
        }
        checkNodeBuilt();
    }

    public void builderEmptyKeyManager() throws Exception {
            ethdroid = new EthDroid.Builder(datadir)
                .withDefaultContext()
                .withChainConfig(ChainConfig.getTestnetConfig())
                .withKeyManager(KeyManager.newKeyManager(datadir))
                .build();

//            Assert.assertNull(ethdroid.getMainAccount());

    }

}
