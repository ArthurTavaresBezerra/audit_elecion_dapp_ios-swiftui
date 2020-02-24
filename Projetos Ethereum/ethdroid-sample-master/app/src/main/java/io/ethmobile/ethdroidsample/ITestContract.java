package io.ethmobile.ethdroidsample;

import io.ethmobile.ethdroid.solidity.ContractType;
import io.ethmobile.ethdroid.solidity.element.event.SolidityEvent;
import io.ethmobile.ethdroid.solidity.element.function.SolidityFunction;
import io.ethmobile.ethdroid.solidity.types.SBool;
import io.ethmobile.ethdroid.solidity.types.SUInt;

/**
 * Created by gunicolas on 08/03/17.
 */

public interface ITestContract extends ContractType {

    SolidityEvent<SUInt.SUInt8> simpleEvent();

    SolidityFunction<SBool> foo();
    SolidityFunction<SUInt.SUInt8> value();
    SolidityFunction<SUInt.SUInt8> bar(SUInt.SUInt8 a);

    SolidityFunction throwEvent();


    /*
    pragma solidity ^0.4.10;
    contract Simple {
        uint8 public value;
        event simpleEvent(uint8);
        function foo() returns(bool){
            return true;
        }
        function bar(uint8 a) returns(uint8){
            value = a;
            return value;
        }
        function throwEvent() {
            simpleEvent(value);
        }
    }
    */

}
