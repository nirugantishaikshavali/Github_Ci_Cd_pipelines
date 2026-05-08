import { LightningElement,api } from 'lwc';
import ACCOUNT_OBJECT from "@salesforce/schema/Account";
import ACCOUNT_NAME_FIELD from "@salesforce/schema/Account.Name";
import ACCOUNT_INDUSTRY_FIELD from "@salesforce/schema/Account.Industry";
import ACCOUNT_DATE_FIELD from "@salesforce/schema/Account.CreatedDate"
import {NavigationMixin} from "lightning/navigation";
export default class RecordEditFormDemo extends  NavigationMixin(LightningElement) {
    @api recordId;
    @api objectApiName;

    fields={
        name:ACCOUNT_NAME_FIELD,
        industry:ACCOUNT_INDUSTRY_FIELD,
        createdDate:ACCOUNT_DATE_FIELD
    }

    successHandler(event){
        let pageRef= {
            type: 'standard__recordPage',
            attributes: {
                recordId: event.detail.id,
                objectApiName: this.objectApiName,
                actionName: 'view'
            }
        };
        this[NavigationMixin.Navigate](pageRef);
    }

    errorHandler(event){
        console.log(JSON.stringify(event.detail))
    }

}