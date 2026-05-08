import { LightningElement,track } from 'lwc';

export default class WelcomeTechJourneyWithAnkit extends LightningElement {
    greeting="Hello";
    @track welcome="Tech Journey With Ankit";

    list_data={name:"shaiksha",age:26}

    changeHandler(event){
        this.greeting="Hi";
        this.welcome="Everyone to Focus on Ui";
        this.list_data.name="shaikshavali";
    }


}