import { LightningElement, wire } from 'lwc';
import { getRecords } from 'lightning/uiRecordApi';
import ACCOUNT_NAME from "@salesforce/schema/Account.Name";
import CONTACT_NAME from "@salesforce/schema/Contact.Name";

export default class GetReordsDemo2 extends LightningElement {
    records = [];

    @wire(getRecords, {
        records: [
            {
                recordIds: ["001g500000A6hE6AAJ"],
                fields: [ACCOUNT_NAME]
            },
            {
                recordIds: ["003g500000ABs7NAAT"],
                fields: [CONTACT_NAME]
            }
        ]
    })
    getAccountContactDetails({ data, error }) {
        if (data) {
            console.log("Account Contact", data);

            this.records = data.results.map(item => ({
                id: item.result.id,
                name: item.result.fields.Name.value
            }));

        } else if (error) {
            console.log("error--->", error);
        }
    }
}