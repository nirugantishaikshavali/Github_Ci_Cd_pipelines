import { LightningElement, wire } from 'lwc';
import getOpportunities from '@salesforce/apex/OpportunityHelper.getOpportunities';
import { publish, MessageContext } from "lightning/messageService";
import recordSelected from "@salesforce/messageChannel/sendContact__c";

export default class OpportunityParent extends LightningElement {
    accountId = '001g500000DDAbZAAX';

    opportunities; 
    error;
    selectedId;
    selectedData;
    @wire(MessageContext)messageContext;


    @wire(getOpportunities, {
        accountId: '$accountId'
    })
    opportunityFunc({ data, error }) {
        if (data) {
            this.opportunities = data;
            this.error = undefined;
            console.log("Opportunity Data", data);
        } else if (error) {
            this.error = error;
            this.opportunities = undefined;
        }
    }

    selectedOpportunity(event){
    this.selectedId = event.detail;
    console.log("selected Opportunity --->", this.selectedId);

    this.selectedData = this.opportunities.find(
        (currData) => currData.Id === this.selectedId
    );

    
    const payload = { lmsData: this.selectedData };
    publish(this.messageContext, recordSelected, payload);
    

    console.log("selectedData", this.selectedData);
}

        



}