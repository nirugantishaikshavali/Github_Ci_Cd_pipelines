// import { LightningElement, wire } from 'lwc';
// import searchRecords from "@salesforce/apex/CustomLookupController.searchRecords";
// const Delay=300;

// export default class CustomLookup extends LightningElement {
//     apiName = "Account";
//     searchValue ;
//     objectLabel= "Account";
//     iconName="standard:account"
//     delayTimeOut;
//     selectedRecord={
//         selectedId:"",
//         selectedName:""
//     };

//     records;
//     error;
//     displayOptions=false;

//     changeHandler(event){
//         window.clearTimeout(this.delayTimeOut);
//         let enteredValue=event.target.value;
//         //debouncing - do not update the reactive property as long as function is being called within a delay.

//         this.delayTimeOut=setTimeout(()=>{
//             this.searchValue=enteredValue;
//             this.displayOptions=true;
//         },Delay)

//     }

    

//     @wire(searchRecords, {
//         objectApiName: '$apiName',
//         searchKey: '$searchValue'
//     })
//     outputs({ data, error }) {
//         if (data) {
//             console.log('data', data);
//             this.records = data;
//             this.error = undefined;
//         } else if (error) {
//             console.log('error', error);
//             this.error = error;
//             this.records = undefined;
//         }
//     }

//     clickHandler(event){
//     const id = event.currentTarget.dataset.id;
//     const name = event.currentTarget.dataset.name;
//     let outputRecord=this.records.find((item)=>item.id===id);
//     this.selectedRecord={
//         selectedId:outputRecord.Id,
//         selectedName:outputRecord.Name
//     }; 
//     this.displayOptions=false;

// }

// get isRecordSelected(){
//     return this.selectedRecord.selectedId===""?false:true;
// }

// }

import { LightningElement, wire,api } from 'lwc';
import searchRecords from "@salesforce/apex/CustomLookupController.searchRecords";

const DELAY = 300;

export default class CustomLookup extends LightningElement {

    @api apiName = "Account";
    @api objectLabel = "Account";
    @api iconName = "standard:account";

    searchValue = '';
    delayTimeout;

    records;
    error;

    displayOptions = false;

    selectedRecord = {
        selectedId: "",
        selectedName: ""
    };

    // 🔍 Handle typing (Debounce)
    changeHandler(event) {
        window.clearTimeout(this.delayTimeout);

        let enteredValue = event.target.value;

        this.delayTimeout = setTimeout(() => {
            this.searchValue = enteredValue;

            // show dropdown only if user typed something
            this.displayOptions = enteredValue ? true : false;

        }, DELAY);
    }

    // 📡 Wire Apex
    @wire(searchRecords, {
        objectApiName: '$apiName',
        searchKey: '$searchValue'
    })
    outputs({ data, error }) {
        if (data) {
            this.records = data;
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.records = undefined;
        }
    }

    // ✅ Select record
    clickHandler(event) {
        const id = event.currentTarget.dataset.id;

        let outputRecord = this.records.find(item => item.Id === id);

        this.selectedRecord = {
            selectedId: outputRecord.Id,
            selectedName: outputRecord.Name
        };

        this.displayOptions = false;
    }

    // ❌ Clear selection
    removeHandler() {
        this.selectedRecord = {
            selectedId: "",
            selectedName: ""
        };

        this.searchValue = '';
        this.records = null;
        this.displayOptions = false;
    }

    // 🔁 UI condition
    get isRecordSelected() {
        return this.selectedRecord.selectedId !== "";
    }
}