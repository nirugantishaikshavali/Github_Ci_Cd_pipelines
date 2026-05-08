import { LightningElement } from 'lwc';

export default class ParentChild3 extends LightningElement {
    display_txt=false
    welcome_msg="Welome to salesforce world"
    handleDisplay(){
        this.display_txt=true;
    }
}