package de.petendi.ethereum.smartcontracts;

import org.apache.commons.io.IOUtils;
import org.ethereum.config.SystemProperties;
import org.ethereum.config.blockchain.FrontierConfig;
import org.ethereum.crypto.ECKey;
import org.ethereum.util.blockchain.SolidityContract;
import org.ethereum.util.blockchain.StandaloneBlockchain;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.JUnit4;
import org.spongycastle.util.encoders.Hex;

import java.io.InputStream;
import java.math.BigInteger;
import java.security.SecureRandom;

@RunWith(JUnit4.class)
public class MultipleRecipientsTest {

    @Test
    public void testSendTo2Recipients() throws Exception {
        InputStream solidityStream =  this.getClass().getResourceAsStream("/MultipleRecipients.sol");
        String solidityString = IOUtils.toString(solidityStream);
        SystemProperties.CONFIG.setBlockchainConfig(new FrontierConfig(new FrontierConfig.FrontierConstants() {
            @Override
            public BigInteger getMINIMUM_DIFFICULTY() {
                return BigInteger.ONE;
            }
        }));
        StandaloneBlockchain standaloneBlockchain = new StandaloneBlockchain();
        SolidityContract solidityContract = standaloneBlockchain.submitNewContract(solidityString);
        standaloneBlockchain.createBlock();
        MultipleRecipients multipleRecipients = new MultipleRecipients(solidityContract);
        ECKey ecKey1 = new ECKey(new SecureRandom());
        ECKey ecKey2 = new ECKey(new SecureRandom());
        String[] recipients = {Hex.toHexString(ecKey1.getAddress()),Hex.toHexString(ecKey2.getAddress())};
        long[] amounts = {1l,1l};
        multipleRecipients.send(2,recipients,amounts);
        standaloneBlockchain.createBlock();
        BigInteger balance1 = standaloneBlockchain.getBlockchain().getRepository().getBalance(ecKey1.getAddress());
        Assert.assertEquals(BigInteger.ONE,balance1);
        BigInteger balance2 = standaloneBlockchain.getBlockchain().getRepository().getBalance(ecKey2.getAddress());
        Assert.assertEquals(BigInteger.ONE,balance2);
    }
}