// SPDX-License-Identifier: MIT
pragma solidity >=0.4.0 <0.9.0;
pragma experimental ABIEncoderV2;


contract Chain{
    uint public productCount = 0;


/*  
    id - It will be used to store product in map and to track the product 
    productName - stores name of the item
    owner - It is of type address that represent account of owner that uniqely identifies the user
    location - stores the location of the item at a particular stage of supply chain
*/
    // struct Date{
    //     uint day;
    //     uint month;
    //     uint year;
    // }

    struct Item{
        uint id;
        uint ownerCount;
        string productName;
        string expiry;
        string manufacture;
        string location;
    }

    struct OwnerDetails{
        address owner;
        // string name;
        // string owner_type;
        string purchaseDate;
    }
/* itemArray stores history of a product */
    mapping(uint => Item) public itemDetails;
    mapping(uint => OwnerDetails[]) public itemOwnerHistory;
    mapping (uint => address) public itemCurrentOwner;

    event addProductCompleted(
        uint _id,
        string _productName,
        string _manufacture,
        string expiry,
        string _location
    );

    event transferOwnerCompleted(
        uint _id,
        address _buyeraddress
    );

    constructor() public{
        //owner =msg.sender;
        addProduct(0,"first product","1-1-2021","1-1-2021",'delhi');
    }

/*
    check whether a product with tracking id already exists in 
    array then return true else return true 
*/

    function productExists(uint _id) view public returns(bool){
        return (itemCurrentOwner[_id]!=address(0)?true:false);    //replace productCount with _id productCount is for development
    }


/*
     let manufacturer to add new item in the list if item already exists then return without adding
     item have a unique id _id , function update current owner of the product in itemOwner mapping
     and push new owner data in itemArray mapping (contains all history of the product)
*/

//add address _owner arg 
    function addProduct(uint _id,string memory _productName,string memory _manufacture,string memory _expiry,string memory _location) public returns(bool) {

        if(productExists(_id)){
            
            return false; // item already exists
        }
        itemCurrentOwner[_id]=msg.sender;
        productCount++;
        itemDetails[_id]=Item(_id,0/*ownercount */,_productName,_expiry,_manufacture,_location);
        
        itemDetails[_id].ownerCount++; // increase the count of owners of a product

        OwnerDetails memory a=OwnerDetails(msg.sender,_manufacture);
        itemOwnerHistory[_id].push(a);

        emit addProductCompleted(_id, _productName, _manufacture ,_expiry,_location);

    }
    
    
/*
    scan item to store whereabouts of the product and change the owner of the product
*/
    function transferOwner(uint _id, address _buyeraddress,string memory _purchaseDate) public returns(string memory){
        //id of the shipment scanned usign QR code
       
        if(msg.sender!=itemCurrentOwner[_id] ){
            //item is already owner of the item
            return "cannot checkout you are not the owner";
        }
        else if( msg.sender==itemCurrentOwner[_id]){
            itemCurrentOwner[_id]=_buyeraddress;
            OwnerDetails memory a=OwnerDetails(_buyeraddress,_purchaseDate);
            itemOwnerHistory[_id].push(a);
            emit transferOwnerCompleted(_id, _buyeraddress);
        }

    }


/*
    function to return all whereabouts of the product with product-id _id
*/
    function getownerHistory(uint _id) public view returns( OwnerDetails[] memory){
        return itemOwnerHistory[_id];
    }
/*
    function to return details of a product
*/
    function getPorductDetails(uint _id) public view returns( Item memory){
        return itemDetails[_id];
    }

}