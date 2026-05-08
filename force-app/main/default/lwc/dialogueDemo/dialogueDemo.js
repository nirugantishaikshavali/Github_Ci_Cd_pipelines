import { LightningElement } from 'lwc';
import LightningAlert from 'lightning/alert';
import LightningConfirm from 'lightning/confirm';

export default class DialogueDemo extends LightningElement {
    async handleAlertModal() {
        const result = await LightningAlert.open({
            message: 'This is the alert message',
            label: 'Alert header',
            variant: 'header',
        });
        console.log('alert result', result);
    }

     async handleConfirmModal() {
        const result = await LightningConfirm.open({
            message: 'This is the confirm message',
            label: 'Confirm deletion?',
            theme: 'warning',
        });
        console.log('confirm result', result);
    }

     async handlePromptModal() {
        const result = await LightningPrompt.open({
            message: 'This is the prompt message',
            defaultValue: 'your input value',
            label: 'Verify your input',
            // use default theme
        });
        console.log('prompt result', result);
    }

}