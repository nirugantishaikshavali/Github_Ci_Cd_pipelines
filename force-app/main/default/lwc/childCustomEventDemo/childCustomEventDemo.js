import { LightningElement } from 'lwc';

export default class ChildCustomEventDemo extends LightningElement {
    handleClick(event){
        let displayData=new CustomEvent('displaymsg');
        this.dispatchEvent(displayData);
    }
}