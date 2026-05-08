public class opportunityDispatcher {
    public static void dispatch(System.TriggerOperation operationType){
        switch on operationType{
            
            when BEFORE_INSERT{
                opportunityHandler.BeforeInsertHandler(Trigger.new);
                opportunityHandler.InsertOpportunityHandler(Trigger.new);
            }
            
            when AFTER_INSERT{
                opportunityHandler.AfterInsertHandler(Trigger.new);
            }
            
    }

}
}