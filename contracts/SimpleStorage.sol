// SPDX-License-Identifier: MIT
pragma solidity ^0.8.31;

contract SimpleStorage {
    // boolean, unit, int, address, bytes
    // automatically inialize by 0
    uint256  favoriteNumber;
    
    //map
    mapping(string=> uint256) public nameToFavoriteNumber;
    
    // structs
    struct People{
        uint256 favoriteNumber;
        string name;
    }
    //People public person = People({favoriteNumber: 2, name: "Ritik"});
    // nint256[] public favoriteNumberList; array
    People[] public people;


    function store(uint256 _favoriteNumber)public virtual{
        favoriteNumber=_favoriteNumber;
        
    }
    // view, pure doesnt use gas
    function retrieve() public view returns(uint256) {
        return favoriteNumber;
    }
    function addPerson(string memory _name, uint256 _favoriteNumber)public {
        //People memory newPerson = People({favoriteNumber: _favoriteNumber, name: _name});
        //people.push(newPerson);
        people.push(People( _favoriteNumber , _name));//same thing
        nameToFavoriteNumber[_name]=_favoriteNumber;
    }
    
}
//0xd9145CCE52D386f254917e481eB44e9943F39138
