import { LightningElement } from 'lwc';

export default class ConditionalRendering extends LightningElement {
    showContent = false;

    changeHandler(event){
        this.showContent=!this.showContent
    }
    

}