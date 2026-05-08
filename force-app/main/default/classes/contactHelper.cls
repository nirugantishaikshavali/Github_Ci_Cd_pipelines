public class contactHelper {
    
    public static void countNoOfContacts(List<Contact>newRecord){
        //find the accountId
        Set<Id> accIds=new Set<Id>();
        
        for(Contact con:newRecord){
            if(con.AccountId!=null){
                accIds.add(con.AccountId);
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
        // Accounts with zero contacts
        for(Id accId : accIds){
            Account acc = new Account();
            acc.Id = accId;
            acc.Number_of_Contacts__c = 0;
            accUpdate.add(acc);
        }
        
        if(!accUpdate.isEmpty()){
    		update accUpdate;
		}
        
    }
    
        
        
    

}