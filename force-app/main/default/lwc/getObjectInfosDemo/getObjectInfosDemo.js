import { LightningElement, wire } from 'lwc';
import { getObjectInfos } from 'lightning/uiObjectInfoApi';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import CONTACT_OBJECT from '@salesforce/schema/Contact';

export default class GetObjectInfosDemo extends LightningElement {
    accountinfo;

    @wire(getObjectInfos, { objectApiNames: [ACCOUNT_OBJECT, CONTACT_OBJECT] })
    objectInfosHandler({ data, error }) {
        if (data) {
            // Find Account object metadata
            const accountObj = data.results.find(
                (obj) => obj.result.apiName === 'Account'
            );

            if (accountObj) {
                this.accountinfo = accountObj.result;
            }
        } else if (error) {
            console.error(error);
        }
    }
}