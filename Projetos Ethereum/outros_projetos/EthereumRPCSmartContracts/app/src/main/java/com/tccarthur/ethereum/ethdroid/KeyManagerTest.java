package com.tccarthur.ethereum.ethdroid;

import android.content.Context;

import org.ethereum.geth.Account;
import org.ethereum.geth.Address;

import java.io.File;
import java.util.List;
import java.util.concurrent.TimeUnit;

import io.ethmobile.ethdroid.KeyManager;

import static io.ethmobile.ethdroid.Utils.deleteDirIfExists;

/**
 * Created by gunicolas on 16/05/17.
 */
public class KeyManagerTest {


    private static final String PASSWORD = "password";
    private Context appContext;
    private String datadir;
    private KeyManager keyManager;
    private Account account;

    public void setUp(Context appContext) {
        this.appContext = appContext;
        datadir = appContext.getFilesDir().getAbsolutePath();
        deleteDirIfExists(new File(datadir + "/keystore"));
    }

//    @Test
    public void newKeyManager() {
        keyManager = KeyManager.newKeyManager(datadir);
        File dir = new File(datadir + "/keystore");
  //      assertTrue(dir.exists() && dir.isDirectory() && dir.list().length == 0);
    }

    //@Test
    public void newAccount() throws Exception {
        newKeyManager();
        account = keyManager.newAccount(PASSWORD);
        String url = account.getURL();
        Address address = account.getAddress();
        String hex = address.getHex();
        //assertTrue(hex.length() > 0 && hex.startsWith("0x"));
        File file = new File(url.substring(11));
        //assertTrue(file.exists() && !file.isDirectory());
        //assertTrue(keyManager.accountIsLocked(account));
    }

    //@Test
    public void newUnlockedAccount() throws Exception {
        newKeyManager();
        account = keyManager.newUnlockedAccount(PASSWORD);
        String url = account.getURL();
        Address address = account.getAddress();
        String hex = address.getHex();
        //assertTrue(hex.length() > 0 && hex.startsWith("0x"));
        File file = new File(url.substring(11));
        //assertTrue(file.exists() && !file.isDirectory());
        //assertFalse(keyManager.accountIsLocked(account));
    }

    //@Test
    public void getAccounts() throws Exception {
        newKeyManager();
        newAccount();
        List<Account> accounts = keyManager.getAccounts();
        //assertTrue(accounts.size() == 1 && accounts.get(0).equals(account));
    }

    //@Test
    public void accountExists() throws Exception {
        newKeyManager();
        newAccount();
        //assertTrue(keyManager.accountExists(account));
    }

    //@Test
    public void lockAccount() throws Exception {
        newKeyManager();
        newAccount();
        keyManager.lockAccount(account);
        //assertTrue(keyManager.accountIsLocked(account));
    }

    //@Test
    public void unlockAccount() throws Exception {
        newKeyManager();
        newAccount();
        keyManager.unlockAccount(account, PASSWORD);
        //assertFalse(keyManager.accountIsLocked(account));
    }

    //@Test
    public void unlockAccountDuring() throws Exception {
        newKeyManager();
        newAccount();
        keyManager.unlockAccountDuring(account, PASSWORD, 5);
        //assertFalse(keyManager.accountIsLocked(account));
        TimeUnit.SECONDS.sleep(5);
        //assertTrue(keyManager.accountIsLocked(account));
    }

    // @Test
    public void deleteAccount() throws Exception {
        newKeyManager();
        newAccount();
        keyManager.deleteAccount(account, PASSWORD);
        File file = new File(account.getURL().substring(11));
        //  assertTrue(!file.exists());
    }

    // @Test
    public void updateAccountPassphrase() throws Exception {
        newKeyManager();
        newAccount();
        String newPassword = PASSWORD + "2";
        keyManager.updateAccountPassphrase(account, PASSWORD, newPassword);
        try {
            keyManager.unlockAccount(account, PASSWORD);
            // fail("passphrase not updated");
        } catch (Exception e) {
        }
        try {
            keyManager.unlockAccount(account, newPassword);
        } catch (Exception e) {
            // fail("passphrase updated but can't unlock with the new one");
        }
    }

    //@Test
    public void signString() throws Exception {
        newKeyManager();
        newAccount();
        keyManager.unlockAndsignString(account, PASSWORD, "hello");
    }

    //@Test(expected = Exception.class)
    public void signStringError() throws Exception {
        newKeyManager();
        newAccount();
        keyManager.signString(account, "hello");
    }

    // @Test
    public void accountIsLocked() throws Exception {
        newKeyManager();
        newAccount();
        boolean got = keyManager.accountIsLocked(account);
        //assertTrue(got);
    }

    //@Test
    public void accountIsUnLocked() throws Exception {
        newKeyManager();
        newUnlockedAccount();
        boolean got = keyManager.accountIsLocked(account);
       // assertFalse(got);
    }


}
