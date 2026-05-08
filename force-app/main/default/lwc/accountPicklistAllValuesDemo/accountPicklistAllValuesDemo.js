import { LightningElement, wire, track } from 'lwc';
import { getObjectInfo, getPicklistValuesByRecordType } from 'lightning/uiObjectInfoApi';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';

export default class AccountPicklistAllValuesDemo extends LightningElement {



    @track picklists = [];
    selectedValues = {};

    // Step 1: Get object info
    @wire(getObjectInfo, { objectApiName: ACCOUNT_OBJECT })
    objectInfo;

    // Step 2: Get ALL picklists
    @wire(getPicklistValuesByRecordType, {
        objectApiName: ACCOUNT_OBJECT,
        recordTypeId: '$objectInfo.data.defaultRecordTypeId'
    })
    picklistData({ data, error }) {
        if (data) {
            const fields = data.picklistFieldValues;

            // Convert object → array for iteration
            this.picklists = Object.keys(fields).map(fieldName => {
                return {
                    fieldName: fieldName,
                    label: fieldName, // You can improve label later
                    options: fields[fieldName].values
                };
            });

        } else if (error) {
            console.error('Error fetching picklists', error);
        }
    }

    // handleChange(event) {
    //     const field = event.target.name;
    //     this.selectedValues[field] = event.target.value;
    // }

    handleChange(event) {
    const field = event.target.name;
    const value = event.target.value;

    this.selectedValues = { ...this.selectedValues, [field]: value };

    // update picklists so UI refreshes
    this.picklists = this.picklists.map(pick => {
        if (pick.fieldName === field) {
            return { ...pick, value };
        }
        return pick;
    });
}
}