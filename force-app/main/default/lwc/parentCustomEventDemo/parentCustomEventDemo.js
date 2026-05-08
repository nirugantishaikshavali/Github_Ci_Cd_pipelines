import { LightningElement } from 'lwc';

export default class ParentCustomEventDemo extends LightningElement {
    displayMessage=false;

    handleChange(event){
        this.displayMessage=true;
    }
}