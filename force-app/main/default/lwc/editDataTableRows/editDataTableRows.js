import { LightningElement, wire, api } from 'lwc';
import getContactBasedOnAccount from '@salesforce/apex/contactController.getContactBasedOnAccount';
import { updateRecord } from 'lightning/uiRecordApi';
import { refreshApex } from "@salesforce/apex";
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

const columns = [
    { label: "First Name", fieldName: "FirstName", editable: true },
    { label: "Last Name", fieldName: "LastName", editable: true },
    { label: "Title", fieldName: "Title", editable: true },
    { label: "Phone", fieldName: "Phone", type: "phone", editable: true },
    { label: "Email", fieldName: "Email", type: "email", editable: true }
];

export default class EditDataTableRows extends LightningElement {
    @api recordId;
    contactData = [];
    columns = columns;
    draftValues = [];
    contactRefreshProp;

    @wire(getContactBasedOnAccount, {
        accountId: "$recordId"
    })
    getContactOuput(result) {
        this.contactRefreshProp = result;
        if (result.data) {
            this.contactData = result.data;
        } else if (result.error) {
            console.log("Error:", result.error);
        }
    }

    async saveHandler(event) {
        let records = event.detail.draftValues;

        let updateRecordsArray = records.map((currItem) => {
            return { fields: { ...currItem } };
        });

        this.draftValues = [];

        try {
            let promises = updateRecordsArray.map((record) => updateRecord(record));
            await Promise.all(promises);

            this.dispatchEvent(
                new ShowToastEvent({
                    title: "Success",
                    message: "Record Updated Successfully",
                    variant: "success"
                })
            );

            await refreshApex(this.contactRefreshProp);

        } catch (error) {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: "Error",
                    message: error.body.message,
                    variant: "error"
                })
            );
        }
    }
}