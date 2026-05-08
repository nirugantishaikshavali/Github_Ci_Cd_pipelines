import { LightningElement, wire } from 'lwc';
import getAccountData from "@salesforce/apex/AccountHelper.getAccountData";

const columns = [
    { label: 'Account Name', fieldName: 'Name' },
    { label: 'Account Industry', fieldName: 'Industry' },
    { label: 'Account Rating', fieldName: 'Rating' },
];

export default class WireDecoratorPropertyFunction extends LightningElement {
    account;
    error;
    columns = columns;

    @wire(getAccountData)
    accountFunction({ data, error }) {
        if (data) {
            let updatedAccount = data.map((currItem) => {
                if (!currItem.hasOwnProperty('Rating') || !currItem.Rating) {
                    return { ...currItem, Rating: "Warm" };
                }
                return { ...currItem };
            });

            this.account = updatedAccount;
            this.error = null;

        } else if (error) {
            this.account = null;
            this.error = error;
        }
    }
}