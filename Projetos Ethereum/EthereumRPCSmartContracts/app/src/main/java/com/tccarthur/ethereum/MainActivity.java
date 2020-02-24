package com.tccarthur.ethereum;

import android.Manifest;
import android.content.pm.PackageManager;
import android.net.wifi.WifiManager;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.design.widget.BottomNavigationView;
import android.support.v4.app.ActivityCompat;
import android.support.v7.app.AppCompatActivity;
import android.text.format.Formatter;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import com.tccarthur.ethereum.ethdroid.contract.ITwoDContract;
import com.tccarthur.ethereum.ethdroid.contract.TwoDContract;

import org.ethereum.geth.*;

import go.Seq;
import io.ethmobile.ethdroid.ChainConfig;
import io.ethmobile.ethdroid.EthDroid;
import io.ethmobile.ethdroid.KeyManager;
import io.ethmobile.ethdroid.solidity.SolidityUtils;
import io.ethmobile.ethdroid.solidity.element.returns.SingleReturn;
import io.ethmobile.ethdroid.solidity.types.SUInt;

import com.tccarthur.ethereum.R;

import java.io.Console;
import java.net.InetAddress;
import java.net.NetworkInterface;
import java.net.SocketException;
import java.sql.Ref;
import java.util.Collections;
import java.util.Enumeration;
import java.util.List;


public class MainActivity extends AppCompatActivity {

    private TextView mTextMessage;
    private TextView mTextMessage2;
    private Button btStartNode;
    private Button btGetValue;
    int PERMISSION_ALL = 1;
    EthDroid ethdroid;
    KeyManager keyManager;
    String dataDir;
    String[] PERMISSIONS = {Manifest.permission.READ_PHONE_STATE,
            Manifest.permission.READ_EXTERNAL_STORAGE,
            Manifest.permission.WRITE_EXTERNAL_STORAGE,
            Manifest.permission.INTERNET,
            Manifest.permission.ACCESS_NETWORK_STATE,
            Manifest.permission.ACCESS_WIFI_STATE};

    private BottomNavigationView.OnNavigationItemSelectedListener mOnNavigationItemSelectedListener = new BottomNavigationView.OnNavigationItemSelectedListener() {

        @Override
        public boolean onNavigationItemSelected(@NonNull MenuItem item) {
            switch (item.getItemId()) {
                case R.id.navigation_home:
                    mTextMessage.setText(R.string.title_home);
                    return true;
                case R.id.navigation_dashboard:
                    mTextMessage.setText(R.string.title_dashboard);
                    return true;
                case R.id.navigation_notifications:
                    mTextMessage.setText(R.string.title_notifications);
                    return true;
            }
            return false;
        }
    };

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        dataDir = getFilesDir() + "/.ethereum10";


        mTextMessage = findViewById(R.id.message);
        mTextMessage2 = findViewById(R.id.message2);
        mTextMessage.setText("");
        mTextMessage2.setText("");
        BottomNavigationView navigation = findViewById(R.id.navigation);
        navigation.setOnNavigationItemSelectedListener(mOnNavigationItemSelectedListener);


        try {
            testeGETH();
        } catch (Exception ex) {

            mTextMessage2.setText(ex.getMessage());
        }


        btStartNode = findViewById(R.id.buttonStartNode);
        btStartNode.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                try {
                    accountTeste();
                } catch (Exception ex) {

                    mTextMessage2.append(ex.getMessage() + "\n");
                }
            }
        });
        btStartNode.setText("Account");

        btGetValue = findViewById(R.id.buttonGetvalue);
        btGetValue.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                try {
                    executeContract();
                } catch (Exception ex) {

                    mTextMessage2.append(ex.getMessage() + "\n");
                }
            }
        });
        btGetValue.setText("Exec trans()");


        if (!hasPermissions(this, PERMISSIONS)) {
            ActivityCompat.requestPermissions(this, PERMISSIONS, PERMISSION_ALL);
        }
    }

    private void testeGETH() throws Exception {
        try {


            Enode enode = new Enode("enode://8e3919af6f605039e51d65781fe8a516bc872decc7e501d5a67d0284200545503a5abaa55223c5f018d822dbd4dce91ebb3295872d9d5fe0be3a4480a2231150" +
                    "@192.168.1.6:30303");
            Enodes enodes = new Enodes();
            enodes.append(enode);


            KeyStore keyStore = new KeyStore(dataDir + "/keystore10", 2l,2l);
            Account mainAccount = keyStore.newAccount("a1");

            NodeConfig nodeConfig = new NodeConfig();
            nodeConfig.setEthereumNetworkID(1114); //Your Private Network-ID
            nodeConfig.setWhisperEnabled(true); // Your Node Settings
            nodeConfig.setEthereumEnabled(true);
            nodeConfig.setBootstrapNodes(enodes);



            String genesis =
                    "{" +
                            "   \"config\": {" +
                            "      \"chainId\": 15," +
                            "      \"homesteadBlock\": 0," +
                            "      \"eip155Block\": 0," +
                            "      \"eip158Block\": 0," +
                            "      \"byzantiumBlock\": 0" +
                            "   }," +
                            "   \"difficulty\": \"400\"," +
                            "   \"gasLimit\": \"2000000\"," +
                            "   \"alloc\": {" +
                            "      \"" + mainAccount.getAddress().getHex() + "\": { " +
                            "          \"balance\": \"100000000000000000000000\" " +
                            "      }" +
                            "   }" +
                            "}";
            //nodeConfig.setEthereumGenesis(genesis);
            Node node = Geth.newNode(dataDir, nodeConfig); //Your Datadirectory
            node.start(); // Check Android Logs if node starts correctly

            NewHeadHandler handler = new NewHeadHandler() {
                @Override
                public void onError(String error) {
                }

                @Override
                public void onNewHead(final Header header) {
                    MainActivity.this.runOnUiThread(new Runnable() {
                        public void run() {
                            mTextMessage2.append("#" + header.getNumber() + ": " + header.getHash().getHex().substring(0, 10) + "…\n");
                        }
                    });
                }
            };

            Context ctx = Geth.newContext();
            EthereumClient ec = node.getEthereumClient();
            ec.subscribeNewHead(ctx, handler, 16);

            NodeInfo info = node.getNodeInfo();
            mTextMessage2.append("My name: " + info.getName() + "\n");
            mTextMessage2.append("My address: " + info.getListenerAddress() + "\n");
            mTextMessage2.append("My protocols: " + info.getProtocols() + "\n");
            mTextMessage2.append("My enode: " + info.getEnode() + "\n\n");
            mTextMessage2.append("My Ip: " + info.getIP() + "\n\n");
            mTextMessage2.append("Latest block: " + ec.getBlockByNumber(ctx, -1).getNumber() + ", syncing...\n");


            BoundContract bc =  Geth.bindContract(new Address("asd"), "asd", ec );
            CallOpts c = new CallOpts();


            Interface i  = Geth.newInterface();
            i.setString("artjir");




        } catch (Exception ex) {
            throw ex;
        }
    }

    private String getIPerrado() {
        try {
            //WifiManager wm = (WifiManager) getApplicationContext(WIFI_SERVICE);
            //String ip = Formatter.formatIpAddress(wm.getConnectionInfo().getIpAddress());
            //return ip;
        }
        catch (Exception ex)
        {
            return ex.getMessage();
        }
        return null;
    }

    public String getIP() {
        try {
            for (Enumeration<NetworkInterface> en = NetworkInterface.getNetworkInterfaces(); en.hasMoreElements();) {
                NetworkInterface intf = en.nextElement();
                for (Enumeration<InetAddress> enumIpAddr = intf.getInetAddresses(); enumIpAddr.hasMoreElements();) {
                    InetAddress inetAddress = enumIpAddr.nextElement();
                    if (!inetAddress.isLoopbackAddress()) {
                        String ip = Formatter.formatIpAddress(inetAddress.hashCode());
                        if (ip.contains("192"))
                            return ip;
                    }
                }
            }
        } catch (SocketException ex) {
            return ex.getMessage();
        }
        return null;
    }

    private void testeEthDroid() throws Exception {
        try {

            keyManager = KeyManager.newKeyManager(getFilesDir() + "/keystore2");
            Account mainAccount = null;
            if (keyManager.getAccounts().isEmpty())
                mainAccount = keyManager.newAccount("a1");
            else
                mainAccount = keyManager.getAccounts().get(0);

            String genesis ="{" +
                            "    \"config\": {" +
                            "     \"chainId\": 15," +
                            "     \"homesteadBlock\": 0," +
                            "     \"eip155Block\": 0," +
                            "     \"eip158Block\": 0" +
                            "    }," +
                            "    \"nonce\": \"0x0000000000000042\"," +
                            "    \"timestamp\": \"0x0\"," +
                            "    \"parentHash\": \"0x0000000000000000000000000000000000000000000000000000000000000000\"," +
                            "    \"gasLimit\": \"0x8000000\"," +
                            "    \"difficulty\": \"0x400\"," +
                            "    \"mixhash\": \"0x0000000000000000000000000000000000000000000000000000000000000000\"," +
                            "    \"coinbase\": \"" + mainAccount.getAddress().getHex() + "\"," +
                            "    \"alloc\": {" +
                            "     \"" + mainAccount.getAddress().getHex() + "\": {\"balance\": \"0x1337000000000000000000\"}" +
                            "    }" +
                            "}";

            String dir = getFilesDir() + "/.ethereum8";
            EthDroid.Builder builder = new EthDroid.Builder(dataDir);
            String bootNode = "enode://8e3919af6f605039e51d65781fe8a516bc872decc7e501d5a67d0284200545503a5abaa55223c5f018d822dbd4dce91ebb3295872d9d5fe0be3a4480a2231150@192.168.15.16:30303?DiscPort:30303";

            ChainConfig chainConfig = new ChainConfig.Builder(1114, genesis, bootNode).build();

            ethdroid = builder
                    .withDatadirPath(dir)
                    .withChainConfig(chainConfig)
                    .withKeyManager(keyManager)
                    .build();
            ethdroid.setMainAccount(mainAccount);
            ethdroid.start();



            mTextMessage2.append("My address: " + ethdroid.getMainAccount().getAddress().getHex() + "\n");
            mTextMessage2.append("My Ip: " + getIPAddress(true) + "\n");

            //mTextMessage2.append("My name: " + info.getName() + "\n");
            //mTextMessage2.append("My protocols: " + info.getProtocols() + "\n\n");
            //mTextMessage2.append("My enode: " + info.getEnode() + "\n\n");
            //mTextMessage2.append("My Ip: " + info.getIP() + "\n\n");

            mTextMessage2.append("Latest block: " + ethdroid.isSyncing() + "\n");

            NewHeadHandler handler = new NewHeadHandler() {
                @Override public void onError(String error) { }
                @Override public void onNewHead(final Header header) {
                    MainActivity.this.runOnUiThread(new Runnable() {
                        public void run() {
                            mTextMessage2.append("#" + header.getNumber() + ": " + header.getHash().getHex().substring(0, 10) + "…\n");
                        }
                    });
                }
            };


        }catch (Exception ex)
        {
            throw ex;
        }
    }

    public static boolean hasPermissions(android.content.Context context, String... permissions) {
        if (context != null && permissions != null) {
            for (String permission : permissions) {
                if (ActivityCompat.checkSelfPermission(context, permission) != PackageManager.PERMISSION_GRANTED) {
                    return false;
                }
            }
        }
        return true;
    }

    private void accountTeste() throws Exception {
        mTextMessage2.setText("");
        mTextMessage2.setText("IsSynced: " + ethdroid.isSynced() + "\n");
        mTextMessage2.setText("IsSyncing: " + ethdroid.isSyncing() + "\n");

//        for (Account account  : ethdroid.getKeyManager().getAccounts())
//            mTextMessage2.append(account.getAddress().getHex() + "\n");

        ethdroid.getKeyManager().unlockAccount(ethdroid.getMainAccount(), "a1");
        mTextMessage2.append(ethdroid.getBalanceOf(ethdroid.getMainAccount()).inEther() + " Balance in Ether \n");
        mTextMessage2.append(ethdroid.getClient().getBalanceAt(new Context(), new Address("0x9368b0c38f490cd8a873dc1975793260d656fb39"),0l).getInt64() + " Balance in BaseCoin \n");
        mTextMessage2.append(ethdroid.getClient().getTransactionByHash(ethdroid.getMainContext(), new Hash("0x66c14d93659b589f15fc3a1a313dbbfe219af72965cf7ab8b46662b78c4c8d80")).encodeJSON() + " Transaciton deploy Contract\n");




        Hash hash =  ethdroid.newTransaction()
                .from(ethdroid.getMainAccount())
                .to("0x9368b0c38f490cd8a873dc1975793260d656fb39")
                .value(new BigInt((long)0.00000006))
                .send();

        mTextMessage2.append(hash.getHex() + "\n");
    }

    private void executeContract() {

        ITwoDContract contract = TwoDContract.getNewInstance(ethdroid, "0x419a042FF81beAD2838D6A506076da7dF3542cF3");

        SUInt.SUInt8 x  = SUInt.SUInt8.fromShort((short)1);
        SUInt.SUInt8 y  = SUInt.SUInt8.fromShort((short)2);

        try {
            //SingleReturn<SUInt.SUInt8> retorno = contract.getValue(x, y).call();
            //mTextMessage.append("\n" + retorno.getElement1().toString() + "\n");


           // Address a  = new Address("0x9368b0c38f490cd8a873dc1975793260d656fb39");
           // BigInt i = ethdroid.getClient().getBalanceAt(ethdroid.getMainContext(),  a,  1l );
            //            mTextMessage.append( "\n" + i.toString() + "\n");

            Hash hash = new Hash("0x66c14d93659b589f15fc3a1a313dbbfe219af72965cf7ab8b46662b78c4c8d80");


            Transaction t =  ethdroid.getClient().getTransactionByHash(ethdroid.getMainContext(), hash);

            mTextMessage2.append(   t.encodeJSON() + "\n");

        }
        catch (Exception ex)
        {
            mTextMessage2.append(  ex.getMessage() + "\n");
        }

    }

    public static String getIPAddress(boolean useIPv4) {
        try {
            List<NetworkInterface> interfaces = Collections.list(NetworkInterface.getNetworkInterfaces());
            for (NetworkInterface intf : interfaces) {
                List<InetAddress> addrs = Collections.list(intf.getInetAddresses());
                for (InetAddress addr : addrs) {
                    if (!addr.isLoopbackAddress()) {
                        String sAddr = addr.getHostAddress();
                        //boolean isIPv4 = InetAddressUtils.isIPv4Address(sAddr);
                        boolean isIPv4 = sAddr.indexOf(':')<0;

                        if (useIPv4) {
                            if (isIPv4)
                                return sAddr;
                        } else {
                            if (!isIPv4) {
                                int delim = sAddr.indexOf('%'); // drop ip6 zone suffix
                                return delim<0 ? sAddr.toUpperCase() : sAddr.substring(0, delim).toUpperCase();
                            }
                        }
                    }
                }
            }
        } catch (Exception ex) { } // for now eat exceptions
        return "";
    }

}

