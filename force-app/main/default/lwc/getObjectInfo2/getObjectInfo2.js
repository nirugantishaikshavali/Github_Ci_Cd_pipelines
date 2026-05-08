import { LightningElement,api,wire } from 'lwc';
import { getRecord, createRecord, updateRecord, deleteRecord, getRecordUi, getObjectInfo,
     generateRecordInputForUpdate } from 'lightning/uiRecordApi';
import ACCOUNT_OBJECT from "@salesforce/schema/Account";
export default class GetObjectInfo2 extends LightningElement {
@api objectApiName;

@wire(getObjectInfo,{objectApiName:ACCOUNT_OBJECT})
objectInfo({data,error}){
    if(data){
        console.log("getObjectInfo",data);
    }else if(error){
        console.log("Error--->",error);
    }

}

}