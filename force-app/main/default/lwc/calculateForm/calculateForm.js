import { LightningElement, api } from 'lwc';
import { FlowAttributeChangeEvent } from 'lightning/flowSupport';

export default class CalculateForm extends LightningElement {
    @api Number1;
    @api Number2;
    @api output;

    handleClick(event) {
        let { name } = event.target;

        // Convert safely to integers
        let num1 = parseInt(this.Number1) || 0;
        let num2 = parseInt(this.Number2) || 0;

        if (name === "ADD") {
            this.output = num1 + num2;
        } 
        else if (name === "SUB") {
            this.output = num1 - num2;
        } 
        else if (name === "MUL") {
            this.output = num1 * num2;
        } 
        else if (name === "DIV") {
            // Handle divide by zero safely (no string!)
            this.output = num2 === 0 ? 0 : Math.floor(num1 / num2);
        }

        // Send value back to Flow
        this.dispatchEvent(
            new FlowAttributeChangeEvent('output', this.output)
        );
    }
}