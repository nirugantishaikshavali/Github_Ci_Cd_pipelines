import { LightningElement } from 'lwc';

export default class ChildHook extends LightningElement {
    constructor(){
        super();
        console.log("Constructor from Child")
    }

    connectedCallback(){
        console.log("connectedCallback from Child")
    }

    renderedCallback(){
        console.log("renderedCallback from Child")
    }

    disconnectedCallback() {
        console.log("DisConnectedCallback from Child");
    }

    errorCallback(error,stack){
        console.log("errorCallback from Child")

    }
}