import { LightningElement } from 'lwc';

export default class DynamicCss extends LightningElement {
    pColor="chocolateColor";

    addHandler(event){
        let element=this.template.querySelector("p")
        element.classList.add("greenColor");
    }

    removeHandler(event){
let element=this.template.querySelector("p")
        element.classList.remove("greenColor");
    }

    toggleHandler(event){
let element=this.template.querySelector("p")
        element.classList.toggle("greenColor");
    }
}