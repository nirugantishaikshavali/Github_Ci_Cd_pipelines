import { LightningElement,api,wire } from 'lwc';
import ACCOUNT_NAME from "@salesforce/schema/Account.Name";
import ACCOUNT_INDUSTRY from "@salesforce/schema/Account.Industry"
import { NavigationMixin } from "lightning/navigation";

export default class RecordFormDemo2 extends NavigationMixin(LightningElement) {
    @api recordId;
    @api objectApiName;
    
    fields=[ACCOUNT_NAME,ACCOUNT_INDUSTRY];

    

    naviageToRecordPage(event){
        let pageRef= {
            type: 'standard__recordPage',
            attributes: {
                recordId: event.detail.id,
                objectApiName: this.objectApiName,
                actionName: 'view'
            }
        }

        this[NavigationMixin.Navigate](pageRef);

    }




}