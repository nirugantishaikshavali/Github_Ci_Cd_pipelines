import { LightningElement,api } from 'lwc';

export default class ChildComponent extends LightningElement {
    @api name;
    // @api rawData;
    @api isDataPrinted=false;
    @api displayGreeting;
    @api displayName;

     _upperName; // private variable

    @api
    set upperName(value) {
        if (value) {
            this._upperName = value.name.toUpperCase();
        }
    }

    get upperName() {
        return this._upperName;
    }
    
}