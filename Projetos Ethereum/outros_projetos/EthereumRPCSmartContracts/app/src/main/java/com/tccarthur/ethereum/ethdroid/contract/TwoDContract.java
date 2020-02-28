package com.tccarthur.ethereum.ethdroid.contract;

import io.ethmobile.ethdroid.EthDroid;
import io.ethmobile.ethdroid.solidity.ContractType;
import io.ethmobile.ethdroid.solidity.element.SolidityElement;
import io.ethmobile.ethdroid.solidity.element.function.SolidityFunction;
import io.ethmobile.ethdroid.solidity.types.SUInt;

public class TwoDContract implements ContractType {

    public static String abi = "[{\"constant\":true,\"inputs\":[{\"name\":\"x\",\"type\":\"uint8\"},{\"name\":\"y\",\"type\":\"uint8\"}],\"name\":\"getValue\",\"outputs\":[{\"name\":\"\",\"type\":\"uint8\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[],\"name\":\"kill\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"inputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"constructor\"}]";

    public static ITwoDContract getNewInstance(EthDroid ethdroid, String address) {
        ITwoDContract contractInstance = ethdroid.getContractInstance(ITwoDContract.class, address);
        return contractInstance;
    }

}



