import { LightningElement,wire } from 'lwc';

// Import message service features required for publishing and the message channel
import { publish, MessageContext } from "lightning/messageService";
import recordSelected from "@salesforce/messageChannel/sendIndependentMessage__c";

export default class LmsPublisherWebComponent extends LightningElement {


  @wire(MessageContext)
  messageContext;

  // Respond to UI event by publishing message
  publishMessage() {
    const payload = { lmsData: "Send Message to Subscriber  user" };

    publish(this.messageContext, recordSelected, payload);
  }


}