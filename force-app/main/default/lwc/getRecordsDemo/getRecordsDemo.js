import { LightningElement,wire,api } from 'lwc';
import Opportunity_NAME_FIELD from "@salesforce/schema/Opportunity.Name";
import CONTACT_NAME_FIELD from "@salesforce/schema/Contact.Name";
import { getRecords } from "lightning/uiRecordApi";

export default class GetRecordsDemo extends LightningElement {
    opportunityRecords;
    contactRecords;
    error;
    output;

    @wire(getRecords,{
        records:[
            {
            recordIds:["006g5000001t1u9AAA","006g50000023Q1dAAE"],
            fields:[Opportunity_NAME_FIELD]
            },
            {
                recordIds:["003g500000ABs7NAAT"],
                fields:[CONTACT_NAME_FIELD]
            }
        ]
    }) getMultipleObjectRecords({data,error}){
    if(data){
        console.log("Multipledata--->",data.results);

        // Transform data
        this.output = data.results.map(item => {
            return item.result.fields.Name.value;
        });

        this.error = null;
    }
    else if(error){
        console.log("error--->",error);
        this.output = null;
        this.error = error;
    }
}


}