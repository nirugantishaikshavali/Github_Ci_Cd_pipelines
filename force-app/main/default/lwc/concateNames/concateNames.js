import { LightningElement } from 'lwc';

export default class ConcateNames extends LightningElement {
    firstName = "";
    lastName = "";
    fullName = "";

    handleChange(event) {
        let { name, value } = event.target;

        if (name === "firstname") {
            this.firstName = value;
        } else {
            this.lastName = value;
        }
    }

    handleClick() {
        this.fullName = this.firstName + " " + this.lastName;

        // reset inputs
        this.firstName = "";
        this.lastName = "";
    }
}