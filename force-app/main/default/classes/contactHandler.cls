public class contactHandler {        
    public static void handleAfterInsert(List<Contact>conList){
        contactHelper.countNoOfContacts(conList);
    }
    
    public static void handleAfterDelete(List<Contact>conList){
        contactHelper.countNoOfContacts(conList);        
    }
    
    public static void handleUndelete(List<Contact>conList){
        contactHelper.countNoOfContacts(conList);        
    }
    
    public static void handleAfterUpdate(Map<Id,Contact>newRecordList,Map<Id,Contact>oldRecordList){
        
        Set<Id> accIds=new Set<Id>();
        for(Contact con:newRecordList.values()){
            Contact oldRecord=oldRecordList.get(con.Id);
            if(con.AccountId!=oldRecord.AccountId){
                accIds.add(con.AccountId);
                accIds.add(oldRecord.AccountId);
            }
        }
        
                //SOQL - WE will count the no_of_contacts in Account
        List<AggregateResult> aggregrateresult=[select AccountId,count(Id) no_of_contacts from Contact where AccountId IN : accIds  group by AccountId];
        
        List<Account> accUpdate=new List<Account>();
        for(AggregateResult ag:aggregrateresult){
            Integer no_of_contacts = (Integer)ag.get('no_of_contacts');
            String accountId = (String)ag.get('AccountId');
            Account acc=new Account();
            acc.Id=accountId;
            acc.Number_of_Contacts__c=no_of_contacts;
            accUpdate.add(acc);
            accIds.remove(accountId);  
        }
        update accUpdate;
        
    }
        
    
        
        
        
        
    
}