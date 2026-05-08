import { LightningElement,wire } from 'lwc';
import getContactListForDataTable from "@salesforce/apex/contactController.getContactListForDataTable";

const columns = [
    { label: 'Name', type:"customNameType",
        typeAttributes:{
        contactName:{
            fieldName:"Name"
        }
    } },
    { label: 'Account Name', fieldName: 'accountLink',type:'url',typeAttributes:{
        label:{
            fieldName:"accountName"
        },
        target:"_blank"
    } },
        //modify the text color of title column then add cellAttributes :{ class: {fieldname:'titleColor'}}
    { label: 'Title', fieldName: 'Title',cellAttributes:{class:{fieldName:"titleColor"}} },
    
    { label: 'Rank', 
        fieldName: 'rank__c',
         type: 'customRank',
        typeAttributes:{
        rankIcon:{
            fieldName:"rankIcon"
        }
    }

     },
    { 
        label: 'Picture', 
        type: 'customPicture',
        typeAttributes:{
            pictureUrl:{
                fieldName:"picture__c"
            }
        },
        cellAttributes:{
            alignment:"center"
        }
    },
    { label: 'Phone', fieldName: 'Phone', type: 'phone' },
    { label: 'Email', fieldName: 'Email', type: 'email' }
];

export default class CustomStyleDataTable extends LightningElement {
    contacts;
    columns=columns;

    @wire(getContactListForDataTable) wiredContacts({data,error}){
        if(data){
            this.contacts=data.map((record)=>{
                let accountLink="/"+record.AccountId;
                let accountName=record.Account.Name;
                let titleColor="slds-text-color_success";
                let rankIcon=record.rank__c>5?"utility:ribbon":"";
                return {
                    ...record,accountLink:accountLink,accountName:accountName,titleColor:titleColor,rankIcon:rankIcon
                };
            });
            console.log("json data",JSON.stringify(data));
        }else{
            console.log(error);
        }
    }
}