import { LightningElement,wire,api } from 'lwc';
import { getRecord, createRecord, updateRecord, deleteRecord, getRecordUi, getFieldValue, getFieldDisplayValue, getRecordCreateDefaults, createRecordInputFilteredByEditedFields, generateRecordInputForCreate, generateRecordInputForUpdate } from 'lightning/uiRecordApi';
import ACCOUNT_NAME from "@salesforce/schema/Account.Name";
import ACCOUNT_NUMBER from "@salesforce/schema/Account.AccountNumber";
import ACCOUNT_REVENUE from "@salesforce/schema/Account.AnnualRevenue"
export default class GetRecordDemo2 extends LightningElement {
    @api recordId;
    record;
    accountNumber;
    annualRevenue;

    @wire(getRecord,{
        recordId:"$recordId",
        fields:[ACCOUNT_NAME,ACCOUNT_NUMBER,ACCOUNT_REVENUE]
    })getAccountInformation({data,error}){
            if(data){
            console.log("<-Record->",data);
            this.record=data.fields.Name.value;
            this.AccountNumber=getFieldValue(data,ACCOUNT_NUMBER);
            this.annualRevenue=getFieldDisplayValue(data,ACCOUNT_REVENUE);
        }else if(error){
            console.log("error",error);
        }
    }
}