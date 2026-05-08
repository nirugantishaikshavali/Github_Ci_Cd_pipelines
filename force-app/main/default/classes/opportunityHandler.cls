public class opportunityHandler {
    public static void BeforeInsertHandler(List<Opportunity>oppList){
        opportunityHelper.discountAmount(oppList);
    }
    public static void AfterInsertHandler(List<Opportunity>oppList){
        opportunityHelper.createTask(oppList);
    }
    public static void InsertOpportunityHandler(List<Opportunity>oppList){
        opportunityHelper.createNewOpportunity(oppList);
    }
    
}