import { LightningElement,wire } from 'lwc';
import getAccountData from "@salesforce/apex/AccountHelper.getAccountData"

const columns = [
    { label: 'Account Name', fieldName: 'Name' },
    { label: 'Acount Industry', fieldName: 'Industry'},
    { label: 'Account Rating', fieldName: 'Rating'},
]; 
export default class WireDecoratorProperty extends LightningElement {
    @wire(getAccountData) accounts;
    columns=columns;
}