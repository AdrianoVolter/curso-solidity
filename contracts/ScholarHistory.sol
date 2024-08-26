// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ScholarHistory{
    string public  gradeStatus;

    constructor(){
        gradeStatus = "empty";
    }

    function updateGradeStatus(int _value) public {
        if (_value < 0 || _value > 10){
            gradeStatus = "Error !";
        }else {
            if(_value >= 7){
            gradeStatus = "Approved";
        } else {
            if (_value == 0){
                gradeStatus = "ZERO !!!";
            }else {
                gradeStatus = "Repproved !!!";
            }
        }
        }
        
    }
}