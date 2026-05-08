import { LightningElement,api,wire } from 'lwc';
import ACCOUNT_NAME from "@salesforce/schema/Account.Name";
import AccOUNT_REVENUE from "@salesforce/schema/Account.AnnualRevenue";
import { getRecord, createRecord, updateRecord, deleteRecord, getRecordUi, getFieldValue, getFieldDisplayValue, getRecordCreateDefaults, createRecordInputFilteredByEditedFields, generateRecordInputForCreate, generateRecordInputForUpdate } from 'lightning/uiRecordApi';

export default class GetRecordDemo extends LightningElement {

    @api recordId;
    errors;
    accName;
    accRevenue;
    accAmount;

    @wire(getRecord,{
        recordId:"$recordId",
        fields:[ACCOUNT_NAME,AccOUNT_REVENUE]

    })getAccountDate({data,error}){
        if(data){
            // this.accName=data.fields.Name.value;
            // this.accRevenue=data.fields.AnnualRevenue.displayValue;
            this.accName=getFieldValue(data,ACCOUNT_NAME);
            this.accRevenue=getFieldDisplayValue(data,AccOUNT_REVENUE);
            this.errors=null;
            console.log(amount);
        }
        else if(error){
            console.log("getRecord Error",error);
            this.records=null;
            this.errors=error;
        }
    }
}