import { LightningElement,api } from 'lwc';
import ACCOUNT_NAME from "@salesforce/schema/Account.Name";
import ACCOUNT_INDUSTRY from "@salesforce/schema/Account.Industry";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import { CloseActionScreenEvent } from "lightning/actions";
export default class ScreenQuickActionDemo extends LightningElement {
    @api recordId;
    @api objectApiName;

    fields={
        accountName:ACCOUNT_NAME,
        accountIndustry:ACCOUNT_INDUSTRY
    }

    successHandler(){
        const event = new ShowToastEvent({
            title: "Sucess",
            message:
                "Record Saved Successfully",
            varient:
                "success"
            });
            this.dispatchEvent(event);
            this.dispatchEvent(new CloseActionScreenEvent());
        }
    

    closeModel(e){
        this.dispatchEvent(new CloseActionScreenEvent());


    }

}