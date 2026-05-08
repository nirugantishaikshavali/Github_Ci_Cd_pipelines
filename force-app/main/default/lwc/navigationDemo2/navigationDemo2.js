import { LightningElement } from 'lwc';
import { NavigationMixin } from "lightning/navigation";

export default class NavigationDemo2 extends NavigationMixin(LightningElement) {
    handleHomePage(){
        
        const pageref={
                    type: 'comm__namedPage',
                    attributes: {
                        name: 'Home'
                    }
                };

        this[NavigationMixin.Navigate](pageref);
    }



    handleAccountList(){
        const pageref={
    type: 'standard__objectPage',
    attributes: {
        objectApiName: 'Account',
        actionName: 'list'
    },
    state: {
        filterName: 'Recent'
  }
    }
    this[NavigationMixin.Navigate](pageref);

    }


    handleAccountNoDefault(){
        const pageref={
    type: 'standard__objectPage',
    attributes: {
        objectApiName: 'Account',
        actionName: 'new'
    }}
    this[NavigationMixin.Navigate](pageref);
}

    handleAccountDefault(){
        const pageref={
    type: 'standard__objectPage',
    attributes: {
        objectApiName: 'Account',
        actionName: 'new'
    },
    state: {
        defaultFieldValues : 'AccountNumber=ACXXXX,CustomCheckbox__c=true,Name=Salesforce%2C%20%231%3DCRM,NumberOfEmployees=35000,OwnerId=005XXXXXXXXXXXXXXX',
        nooverride: '1'
    }
}
    this[NavigationMixin.Navigate](pageref);


    }

    handleAccountEditPage(){
        const pageref={
        type: 'standard__recordPage',
        attributes: {
            recordId: '001g500000A6hE6AAJ',
            objectApiName: 'Account',
            actionName: 'edit'
        }
}
    this[NavigationMixin.Navigate](pageref);


}

}