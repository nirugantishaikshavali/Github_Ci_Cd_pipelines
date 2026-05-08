import { LightningElement, wire } from 'lwc';
import { getObjectInfo, getPicklistValues, getPicklistValuesByRecordType } from "lightning/uiObjectInfoApi";

import CONTACT_OBJECT from "@salesforce/schema/Contact";
import LEAD_SOURCE from "@salesforce/schema/Contact.LeadSource";

export default class GetPicklistValueDemo extends LightningElement {
    recordTypeId;
    leadSource;
    selectedValue;

    objectApiName = CONTACT_OBJECT; // better to use schema reference

    // Step 1: Get default record type Id
    @wire(getObjectInfo, { objectApiName: CONTACT_OBJECT })
    objectInfo({ data, error }) {
        if (data) {
            this.recordTypeId = data.defaultRecordTypeId;
        } else if (error) {
            console.error(error);
        }
    }

    // Step 2: Single picklist (LeadSource)
    @wire(getPicklistValues, { recordTypeId: '$recordTypeId', fieldApiName: LEAD_SOURCE })
    getPicklistData({ data, error }) {
        if (data) {
            this.leadSource = data.values.map((item) => ({
                label: item.label,
                value: item.value
            }));
        } else if (error) {
            console.error("Contact Error --->", error);
        }
    }

    handleChange(event) {
        this.selectedValue = event.target.value;
    }

    // ✅ Step 3: ALL picklists using record type
    @wire(getPicklistValuesByRecordType, {
        objectApiName: '$objectApiName',
        recordTypeId: '$recordTypeId'
    })
    picklistByRecordType({ data, error }) {
        if (data) {
            console.log("All Picklists --->", data);

            // Example: Access LeadSource from this API
            const leadSourceValues = data.picklistFieldValues.LeadSource.values;

            console.log("LeadSource from getPicklistValuesByRecordType --->", leadSourceValues);

        } else if (error) {
            console.error("Error in getPicklistValuesByRecordType --->", error);
        }
    }
}