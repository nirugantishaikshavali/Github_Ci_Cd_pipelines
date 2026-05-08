import getAccountData from '@salesforce/apex/AccountHelper.getAccountData';
import { LightningElement,wire } from 'lwc';
import { getObjectInfo,getPicklistValues } from "lightning/uiObjectInfoApi";
import ACCOUNT_OBJECT from "@salesforce/schema/Account";
import ACCOUNT_INDUSTRY from "@salesforce/schema/Account.Industry";

const columns = [
    { label: 'Account Name', fieldName: 'Name' },
    { label: 'Account Industry', fieldName: 'Industry' },
    { label: 'Account Rating', fieldName: 'Rating' },
    
];
export default class ImperativeApexDemo extends LightningElement {
    columns=columns;
    data=[];
    seletedIndustry;

    
      @wire(getObjectInfo, { objectApiName: ACCOUNT_OBJECT })
        propertyOrFunction;

        @wire(getPicklistValues, { recordTypeId: "$propertyOrFunction.data.defaultRecordTypeId", fieldApiName: ACCOUNT_INDUSTRY })
        industryPickList;


    

    handleClick(){
        getAccountData({ industry: this.seletedIndustry }).then((result)=>{
            this.data=result;
            console.log("Account Records",result);

        })
        .catch((error)=>{
            console.log("Account error",error);
        })

    }

   

     handleChange(event) {
        this.seletedIndustry = event.target.value;
    }
}