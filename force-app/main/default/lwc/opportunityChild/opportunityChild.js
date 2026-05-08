import { LightningElement,api,wire } from 'lwc';
// Import message service features required for publishing and the message channel
import { publish, MessageContext } from "lightning/messageService";
import recordSelected from "@salesforce/messageChannel/sendContact__c";


export default class OpportunityChild extends LightningElement {
    @api opportunities;

    @wire(MessageContext)messageContext;

    handleclick(event){

        const selectedId = event.currentTarget.dataset.id;
        console.log('Selected Id:', selectedId);


        const selectEvent = new CustomEvent("select", {
            detail: selectedId
        });
                this.dispatchEvent(selectEvent);


        const payload = { lmsData: selectedId };
        publish(this.messageContext, recordSelected, payload);
    
    
            }


        
}