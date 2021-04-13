// SPDX-License-Identifier: MIT
pragma solidity >=0.4.0 <0.9.0;

contract Chain{
    uint public productCount = 0;


    struct Item{
        
        uint id;  /*id will be used to store product in map and to track the product */
        string productName;
        address owner; //will be changed from string to address
        string location;  /* store location of a product at a cetrain time */
    }
    mapping(uint => Item) public itemArray;

    constructor() public{
        //owner =msg.sender;
        storeProduct(0,"first product",0xDEE7796E89C82C36BAdd1375076f39D69FafE252,'delhi');
    }

   /* replaced by the function storeProduct
    function setInfo(uint _id,string memory _productName,address _owner,string memory _location) public{
        productCount++;
        itemArray[_id]=Item(_id, _productName,_owner,_location);
        //itemArray[productCount]=Item(_id,_productName,_location);
    }*/



    /* check whether a product with tracking id already exists in 
    array then return true else return true */

    function productExists(uint _id) view public returns(bool){
        return (itemArray[productCount].owner!=address(0)?true:false);    //replace productCount with _id productCount is for development
    }

    /*add new item in the array with the tracking id _id if item  already exist do not add second time*/
    function storeProduct(uint _id,string memory _productName,address _owner,string memory _location) public returns(bool) {

        if(productExists(_id)){
          
            return false;
        }
        productCount++;
        itemArray[productCount]=Item(_id,_productName,_owner,_location); //replace productCount with _id productCount is for development
    }


    /* scan item to store whereabouts of the product*/
    function scanShipment() public {
        uint _id; //id of the shipment scanned usign QR code
        if(msg.sender==itemOwner[_id]){
            //item is already owner of the item
            return false;
        }
    }    
    /* function that allow a client to remove any item */
}