import { LightningElement, wire } from 'lwc';
import LOGO from "@salesforce/resourceUrl/MyLogo";
import CONTENT_ASSET from "@salesforce/contentAssetUrl/mysore_sandal";
import GREETING from "@salesforce/label/c.Company_Custom_Label";
import SALESFORCE_PLATFORM from "@salesforce/label/c.Welcome_Message";
import USER_ID from "@salesforce/user/Id";
import NAME_FIELD from "@salesforce/schema/User.Name";
import DISPLAY_TEXT from "@salesforce/customPermission/display_Text";
import {loadStyle} from "lightning/platformResourceLoader";
import ANIMATE from "@salesforce/resourceUrl/ThirdPartyCss";

import { getRecord, getFieldValue } from 'lightning/uiRecordApi';

export default class StaticResourceDemo extends LightningElement {
    myLogoImage = LOGO;
    myLogoAsset = CONTENT_ASSET;
    isFirstLoad=true

    label = {
        platform: SALESFORCE_PLATFORM,
        greeting: GREETING
    };

    name = "";

    @wire(getRecord, {
        recordId: USER_ID,
        fields: [NAME_FIELD] // ✅ FIXED
    })
    wired_user_output({ data, error }) {
        if (data) {
            console.log("Logged in User Details", data);
            this.name = getFieldValue(data, NAME_FIELD);
        } else if (error) {
            console.log("Logged in user details error", error);
        }
    }

    renderedCallback(){
        if(this.isFirstLoad){
            this.isFirstLoad=false;
            loadStyle(this,ANIMATE).then(()=>{console.log("File Loaded Successfully");})
            .catch((error)=>{
                console.log("File Load Failes",error);
            })
        }
    }

    get checkPermission(){
        return DISPLAY_TEXT;
    }
}