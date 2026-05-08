import { LightningElement, wire, api } from 'lwc';
import CASE_OBJECT from '@salesforce/schema/Case';
import STATUS_FIELD from '@salesforce/schema/Case.Status';

import { 
    getObjectInfo, 
    getPicklistValues, 
    getRecord 
} from 'lightning/uiObjectInfoApi';

import { getFieldValue } from 'lightning/uiRecordApi';

export default class CaseProgressIndicator extends LightningElement {

    @api recordId;

    statusOptions = [];
    caseStatusValue;

    // 1. Get Object Info
    @wire(getObjectInfo, { objectApiName: CASE_OBJECT })
    objectInfo;

    // 2. Safe getter for recordTypeId
    get recordTypeId() {
        return this.objectInfo?.data?.defaultRecordTypeId;
    }

    // 3. Get Picklist Values
    @wire(getPicklistValues, {
        recordTypeId: '$recordTypeId',
        fieldApiName: STATUS_FIELD
    })
    picklistHandler({ data, error }) {
        if (data) {
            this.statusOptions = data.values;
        } else if (error) {
            console.error('Error fetching picklist values', error);
        }
    }

    // 4. Get Current Record Value
    @wire(getRecord, {
        recordId: '$recordId',
        fields: [STATUS_FIELD]
    })
    recordHandler({ data, error }) {
        if (data) {
            this.caseStatusValue = getFieldValue(data, STATUS_FIELD);
        } else if (error) {
            console.error('Error fetching record', error);
        }
    }
}