import { LightningElement } from 'lwc';

export default class Calculator extends LightningElement {
    result=0;
    number1="";
    number2="";
    showResult=false;
   

    changeHandler(event){
        let {name,value}=event.target;
        if(name==="Number1"){
            this.number1=value;

        }else if(name==="Number2"){
            this.number2=value;
        }
    }

    handleClick(event){
        this.showResult=true;
        let name=event.target.name;
         let num1 = Number(this.number1);
        let num2 = Number(this.number2);

        if(name==="ADD"){
            this.result=num1+num2; 

        }else if(name==="SUB"){
            this.result=num1-num2; 

        }else if(name==="MUL"){
            this.result=num1*num2; 

        }else{
            this.result=num1/num2; 
        }

        this.number1="";
        this.number2="";
    }






}