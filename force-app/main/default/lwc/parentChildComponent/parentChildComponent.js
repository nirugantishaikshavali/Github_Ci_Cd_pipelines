import { LightningElement } from 'lwc';

export default class ParentChildComponent extends LightningElement {
    displayMsg=false;
    text="Welcome to Salesforce LWC";

    changeDisplayMsg(event){
        this.displayMsg=true;

    }
}