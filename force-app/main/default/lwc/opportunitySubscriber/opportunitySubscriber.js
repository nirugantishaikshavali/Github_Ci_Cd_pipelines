import { LightningElement,wire } from 'lwc';
import {
  subscribe,
  unsubscribe,
  APPLICATION_SCOPE,
  MessageContext,
} from "lightning/messageService";
import recordSelected from "@salesforce/messageChannel/sendContact__c";

export default class OpportunitySubscriber extends LightningElement {
      subscription = null;
        selectedData;

@wire(MessageContext)
  messageContext;

  // Encapsulate logic for Lightning message service subscribe and unsubsubscribe
  subscribeToMessageChannel() {
    if (!this.subscription) {
      this.subscription = subscribe(
        this.messageContext,
        recordSelected,
        (message) => this.handleMessage(message),
        { scope: APPLICATION_SCOPE },
      );
    }
  }

  unsubscribeToMessageChannel() {
    unsubscribe(this.subscription);
    this.subscription = null;
  }

  // Handler for message received by component
  handleMessage(message) {
    this.selectedData = message.lmsData;
  }

  // Standard lifecycle hooks used to subscribe and unsubsubscribe to the message channel
  connectedCallback() {
    this.subscribeToMessageChannel();
  }

  disconnectedCallback() {
    this.unsubscribeToMessageChannel();
  }

}