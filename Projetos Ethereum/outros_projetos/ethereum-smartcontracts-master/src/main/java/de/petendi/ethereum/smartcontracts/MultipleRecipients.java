package de.petendi.ethereum.smartcontracts;

import org.ethereum.util.blockchain.SolidityContract;

public class MultipleRecipients {
    protected final SolidityContract solidityContract;


    public MultipleRecipients(SolidityContract solidityContract) throws Exception {
        this.solidityContract = solidityContract;
    }

    public void send(long totalAmount, String[] recipients, long[] amounts) {
        solidityContract.callFunction(totalAmount, "send", recipients, amounts);
    }


}
