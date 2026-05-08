public class ContentVersionDispatch {
    
    public static void dispatch(System.TriggerOperation operationType){
        
        switch on operationType{
            WHEN AFTER_INSERT{
                ContentVersionHandler.AFTER_INSERT(Trigger.new);
            }
        }
        
    }

}