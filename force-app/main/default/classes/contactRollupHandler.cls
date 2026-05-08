public class contactRollupHandler {
    
    public static void AfterInsertHandler(Map<Id,Contact>newRecordsMap)
    {
       contactRollupHelper.countContact(newRecordsMap);    
    }       
    
    public static void AfterDeleteHandler(Map<Id,Contact>oldRecordsMap)
    {
       contactRollupHelper.countContact(oldRecordsMap);    
    }       
    
        
     public static void AfterUnDeleteHandler(Map<Id,Contact>newRecordsMap)
    {
       contactRollupHelper.countContact(newRecordsMap);    
    }
    
    public static void AfterUpdateHandler(Map<Id,Contact>newRecordsMap,Map<Id,Contact>oldRecordsMap){
        
        Set<Id>accountIdSet=new Set<Id>();
        for(Contact newRecord:newRecordsMap.values()){
            Contact oldRecord=oldRecordsMap.get(newRecord.Id);
            
            if(newRecord.AccountId!=oldRecord.AccountId){
                accountIdSet.add(newRecord.AccountId);
                accountIdSet.add(oldRecord.AccountId);
            }
        }
        
                //2.By using SOQL we find count of Contacts for related Account
        List<AggregateResult> aggResult=[select AccountId,count(Id) no_of_contact from Contact where AccountId IN: accountIdSet group by AccountId];
        List<Account>accList=new List<Account>();
        for(AggregateResult agg:aggResult){
            
            String accId=(String)agg.get('AccountId');
            Integer no_of_contact =(Integer)agg.get('no_of_contact');
            
            Account acc=new Account();
            acc.Id=accId;
            acc.Number_of_Contacts__c=no_of_contact;
            accList.add(acc);
        }
        update accList;

        
        
    }
    
}