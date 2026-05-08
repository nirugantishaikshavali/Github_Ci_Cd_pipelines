import { LightningElement } from 'lwc';

export default class ChildParentComponent extends LightningElement {
    clickHandler(event){
    let mycustomevent=new CustomEvent("displaymsg");
    this.dispatchEvent(mycustomevent);
    }
    
}