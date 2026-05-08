public class caseTriggerDispatch {    
    public static void dispatch(System.TriggerOperation opertionType)
    {
        switch on opertionType{
            when AFTER_INSERT{
                if(caseTriggerHelper.running==false){
                caseTriggerHandler.afterInsertHandler(Trigger.New);
                }
            }
            when else{
                
            }
        }
        
    }
}