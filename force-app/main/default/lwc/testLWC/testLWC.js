import { LightningElement } from 'lwc';
export default class TestLWC extends LightningElement {

    yourName='';
    nameChangeHandler(event){
        this.yourName=event.target.value;
    }

    handleClick(event){
        alert('Hello'+this.yourName);
    }

}