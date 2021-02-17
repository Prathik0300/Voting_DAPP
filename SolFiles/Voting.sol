pragma solidity ^0.5.0;

contract Users {
    mapping(uint => voter) public voters;
    mapping(uint => owner) public owners;

    uint[] voterID;
    uint[] ownerID;

    struct voter {
        uint voterID;
        string name;
        uint age;
        address owner;
        string district;
    }

    struct owner{
        uint ownerID;
        uint voterID;
        string name;
        uint age;
        address owner;
        string district;
    }

    event VoterCreated(
        uint voterID,
        string name,
        uint age,
        address owner,
        string district
    );

    event OwnerCreated(
        uint ownerID,
        uint voterID,
        string name,
        uint age,
        address owner,
        string district
    );

    function CreateVoter(uint _id,string memory _name,uint _age,string memory _district) public {
        require(bytes(_name).length > 0);
        require(bytes(_district).length > 0);
        require(_age > 0);
        require(ValidVoterID(_id));
        voterID.push(_id);
        voters[_id] = voter(_id,_name,_age,msg.sender,_district);
        emit VoterCreated(_id,_name,_age,msg.sender,_district);
    }

    function ValidVoterID(uint _id) view public returns (bool){
        for(uint i=0; i < voterID.length;i++){
            if (voterID[i]==_id) {
                return false;
            }
        }
        return true;
    }

    function CreateOwner(uint _id ,uint _id1,string memory _name,uint _age,string memory _district) public {
        require(bytes(_name).length > 0);
        require(bytes(_district).length > 0);
        require(_age > 0);
        require(ValidOwnerID(_id));
        owners[_id] = owner(_id,_id1,_name,_age,msg.sender,_district);
        ownerID.push(_id);
        require(ValidVoterID(_id1));
        voterID.push(_id1);
        voters[_id1] = voter(_id1,_name,_age,msg.sender,_district);
        emit OwnerCreated(_id,_id1,_name,_age,msg.sender,_district);
        emit VoterCreated(_id1,_name,_age,msg.sender,_district);
    }

    function ValidOwnerID(uint _id) view public returns (bool){
        for(uint i=0; i < ownerID.length;i++){
            if (ownerID[i]==_id) {
                return false;
            }
        }
        return true;
    }
}