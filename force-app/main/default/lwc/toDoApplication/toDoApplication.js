import { LightningElement } from 'lwc';

export default class ToDoApplication extends LightningElement {
    taskname="";
    taskdate=null;
    incompleteTask=[];
    completeTask=[];

    changeHandler(event){
        let {name,value}=event.target;
        if(name=="taskname"){
            this.taskname=value;
        }
        else if(name=="enddate"){
            this.taskdate=value;
            
        }
    }

    resetHandler(){
        this.taskdate=null;
        this.taskname="";
    }

    addTaskHandler(){
        //if taskendDate is missing ,then populate today date as end date.
        if(!this.taskdate){
            this.taskdate=new Date().toISOString().slice(0,10);
        }

        if(this.validateTask()){
            //Array of object 
           this.incompleteTask=[...this.incompleteTask,{
            taskname:this.taskname,
            taskdate:this.taskdate
        }
           ];
           this.resetHandler();
           let sortedArray=this.sortTask(this.incompleteTask);
           this.incompleteTask = [...sortedArray];
            console.log("this.incompleteTask",this.incompleteTask);

        }

    
    }

    validateTask(){
        let isValid=true;
        //feth element query
        let element=this.template.querySelector(".taskname");

        //Condition 1 --- Check if task is Empty
        if(!this.taskname){
            isValid=false;
        }else{
            //Inside the Array data is present or not - find
            //If find method,will find an item in array it will return task item if not found ,it will return undefind
            let taskItem=this.incompleteTask.find((currItem)=>
                currItem.taskname===this.taskname && 
                currItem.taskdate===this.taskdate 
        );

        //if item is found ,then flag is false
        if(taskItem){
            isValid=false;
            element.setCustomValidity("Task already exists");
        }

        if(isValid){
            element.setCustomValidity("");
        } 
        
        element.reportValidity();
        return isValid;



        }

        //Condition 2 --- if task name is not empty then chek for duplicate

    }

    sortTask(inputArr){
        let sortedArray=inputArr.sort((a,b)=>{
            const dateA=new Date(a.taskdate);
            const dateB=new Date(b.taskdate);
            return dateA - dateB;
        })
        return sortedArray;
    }

    removeHandler(event){
        //from incomplete array,remove the item
        let index=event.target.name;
        this.incompleteTask.splice(index,1);
        let sortedArray=this.sortTask(this.incompleteTask);
        this.incompleteTask = [...sortedArray];
        console.log("this.incompleteTask",this.incompleteTask);

    }

    completeTaskHandler(event){
        //from incomplete array,remove the item
        let index=event.target.name;
        let removeItem=this.incompleteTask.splice(index,1);
        let sortedArray=this.sortTask(this.incompleteTask);
        this.incompleteTask = [...sortedArray];
        console.log("this.incompleteTask",this.incompleteTask);


        //add the same item into the complete item
        this.completeTask=[...this.completeTask,removeItem[0]];


    }


}