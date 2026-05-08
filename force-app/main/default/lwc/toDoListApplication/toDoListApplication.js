import { LightningElement } from 'lwc';

export default class ToDoListApplication extends LightningElement {
    taskname="";
    taskEndDate=null;
    toDoList=[];
    completedList=[];

    changeHandler(event){
        let {name,value}=event.target;
        if(name==="taskname"){
            this.taskname=value;
        }else if(name==="taskenddate"){
            this.taskEndDate=value;
        }
    }

    addTaskHandler(){
        if(this.validateTask()){
           this.toDoList=[...this.toDoList,
                {
                id: Date.now(),
                taskname:this.taskname,
                 taskEndDate:this.taskEndDate
                }];
            this.resetHandler();
            let sorted_array=this.sortItems(this.toDoList);
            this.toDoList=[...sorted_array];
        }
        console.log("<---toDoList--->",this.toDoList);
    }



    validateTask() {
        let validate = true;
        let element=this.template.querySelector(".taskname");

        if(!this.taskEndDate){
            this.taskEndDate=new Date().toISOString().slice(0,10);
        }

         // clear previous errors
        element.setCustomValidity("");

        if(!this.taskname){
            validate=false;
            // element.setCustomValidity("Task name is required");
        }
        else{
            let dupTaskFound = this.toDoList.find(
    (currItem) =>
        currItem.taskname === this.taskname &&
        currItem.taskEndDate === this.taskEndDate
);
            if(dupTaskFound){
                validate=false;
                element.setCustomValidity("Task is already available");
            }
        }
        element.reportValidity();
        
        return validate;

    }

    resetHandler(){
        this.taskname="";
        this.taskEndDate=null;
    }

    sortItems(arrItems){
        arrItems.sort((a,b)=>{
            let dataA=new Date(a.taskEndDate);
            let dataB=new Date(b.taskEndDate);
        return dataA-dataB;
        })
    return arrItems;
    }
}