import { LightningElement,api } from 'lwc';
import { FlowAttributeChangeEvent } from 'lightning/flowSupport';
export default class InputFormFlow extends LightningElement {
    @api inputName;
    changeHandler(event){
        this.inputName=event.target.value;
        const attributeevent=new FlowAttributeChangeEvent("inputName",this.inputName);
        this.dispatchEvent(attributeevent);
    }

}