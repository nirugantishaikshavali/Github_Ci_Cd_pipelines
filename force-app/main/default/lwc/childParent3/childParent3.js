import { LightningElement } from 'lwc';

export default class ChildParent3 extends LightningElement {

    displayMessage(){
        let result=new CustomEvent("displaymessage",{
            fields:{msg:"Succesfully Completed"}
        })
        this.dispatchEvent(result);
    }
}