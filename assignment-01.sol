pragma solidity ^0.5.0;

contract enrollStudents {
    address payable private myAddress = 0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c; //my EOA address
    uint numberOfStudents = 0;
    
    enum Gender {
        male,  //0
        female //1
     } 
     enum Reg {
         online, //0
         onsite  //1
     }
     
    struct Student {  //custom datatype to store student's details in diff. datatypes
        uint rollNo;
        string name;
        Gender gender;
        Reg regisType;
        bool degree;
    }
    
    mapping (uint => Student) studentsData;  //creating dictionary to add students data
    
    modifier verify() {  //runs before the function and if the condition meets then it will lwt the function run
        if(msg.value >= 2 ether) {
            _;
        }
    }
    
    function enrollStu(uint _rollNo, string memory _name, Gender _gender, Reg _regisType, bool _degree) public payable verify() returns(uint) {  //function which feeds the studenta data to mapping as well as send the recieved money to the owner i.e myAddress //used _ to distinguish b/w state var and parameters
        myAddress.transfer(msg.value); //sends recieved money to owner
        studentsData[_rollNo] = Student(_rollNo, _name, _gender, _regisType, _degree); //feeds data to key value pair
        return (numberOfStudents+1); //sends number of student count
    }
    
    function balanceCheck() public view returns(uint) {  //checks account balance
        return myAddress.balance;
    }
}