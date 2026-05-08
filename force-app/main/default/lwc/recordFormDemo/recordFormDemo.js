import { LightningElement,api } from 'lwc';
import NAME_FIELD from "@salesforce/schema/Account.Name";
import INDUSTRY_FIELD from "@salesforce/schema/Account.Industry";
import RATING_FIELD from "@salesforce/schema/Account.Rating";
import REVENUE_FIELD from "@salesforce/schema/Account.AnnualRevenue";
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from "lightning/navigation";

export default class RecordFormDemo extends  NavigationMixin(LightningElement) {
    @api recordId;
    @api objectApiName;
    fieldList=[NAME_FIELD,INDUSTRY_FIELD,RATING_FIELD,REVENUE_FIELD];

    showToast() {
    const event = new ShowToastEvent({
      title: "sucess",
      message:"Record Updated Sucessfully",
      variant:"success"
    });
    this.dispatchEvent(event);
  }

  navigateToRecordPage(event) {
    console.log("event.detail", event.detail);

    const recordId = event.detail.id; // ✅ get recordId from success event

    this[NavigationMixin.Navigate]({
        type: 'standard__recordPage',
        attributes: {
            recordId: recordId,
            objectApiName: this.objectApiName,
            actionName: 'view'
        }
    });
}

}