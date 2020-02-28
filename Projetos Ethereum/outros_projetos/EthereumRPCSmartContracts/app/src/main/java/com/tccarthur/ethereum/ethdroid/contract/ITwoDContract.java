package com.tccarthur.ethereum.ethdroid.contract;

import io.ethmobile.ethdroid.solidity.ContractType;
import io.ethmobile.ethdroid.solidity.element.SolidityElement;
import io.ethmobile.ethdroid.solidity.element.function.SolidityFunction;
import io.ethmobile.ethdroid.solidity.types.SUInt;

public interface ITwoDContract extends ContractType{



    SolidityFunction<SUInt.SUInt8> getValue(SUInt.SUInt8 x, SUInt.SUInt8 y);

    SolidityFunction kill();
}



