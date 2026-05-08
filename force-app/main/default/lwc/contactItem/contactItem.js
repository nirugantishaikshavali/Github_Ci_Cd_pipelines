import { LightningElement,api } from 'lwc';

export default class ContactItem extends LightningElement {
    @api contact;

    changeHandler(event){
        event.preventDefault();

        const selectionevent=new CustomEvent("selection",{
            detail:this.contact.Id
        });

        this.dispatchEvent(selectionevent);
    }

    


}