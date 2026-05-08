public class contactDispatcher {
    //System.TriggerOperation
    public static void dispatch(System.TriggerOperation operationType){
        switch on operationType{
            when BEFORE_UPDATE{
                contactHandler.BeforeUpdateHandler(Trigger.new);
            }
            
            
        }   
    }
}