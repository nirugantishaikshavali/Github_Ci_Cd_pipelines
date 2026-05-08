import { LightningElement,wire } from 'lwc';
import {getObjectInfo } from 'lightning/uiObjectInfoApi';
import ACCOUNT_OBJECT from "@salesforce/schema/Account";
export default class GetObjectInfoDemo extends LightningElement {
    accountRelationship;

   @wire(getObjectInfo,{objectApiName:ACCOUNT_OBJECT})
   objectInfo({data,error}){
    if(data){
        this.accountRelationship=data.childRelationships.map((data)=>data.relationshipName);
        console.log("<---getObjectInfo Data",this.accountRelationship);

    }
    else if(error){
        console.log("<---getObjectInfo Error--->",error);
    }
   }

}