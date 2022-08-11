//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract TestContract{
    function sayFirstName() external view returns(string memory, uint){
        return("Jason", block.timestamp);
    }
    function sayLastName() external view returns(string memory, uint){
        return("Charles", block.timestamp);
    }
    function getSelector1() external pure returns(bytes4){
        return bytes4(keccak256(abi.encodePacked("sayFirstName()")));
    }
    function getSelector2() external pure returns(bytes memory){
        return abi.encodeWithSignature("sayLasttName()");
    }
}

contract MultiCall{
    function useMultiCall(address[] calldata _contracts, bytes[] calldata _data) external view returns(bytes[] memory){
        require(_contracts.length == _data.length, "Invalid data input");
        bytes[] memory result = new bytes[](_data.length);
        for (uint i; i < _data.length; i++){
           (bool confirm, bytes memory data) = _contracts[i].staticcall(_data[i]);
           require(confirm, "call failed");
            result[i] = data; 
        }
        return result;
    }
}
