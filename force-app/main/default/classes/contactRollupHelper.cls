public class contactRollupHelper {
   /* public static void createContact(List<Contact>conList){
        Set<Id>accIds=new Set<Id>();
        
        for(Contact con:conList){
            accIds.add(con.AccountId);
        }
        
        Map<Id, Account> accountMap = new Map<Id, Account>([
SELECT Id, ShippingStreet, ShippingCity, ShippingState,
ShippingPostalCode,
ShippingCountry, BillingStreet, BillingCity, BillingState,
BillingPostalCode, BillingCountry
FROM Account WHERE Id IN : accountIdSet]);
        
for(Contact con : contactList){
    Account accAddressInfo = accountMap.get(con.AccountId);
        if( con.AccountId != Null){
            con.MailingStreet = accAddressInfo.ShippingStreet;
            con.MailingCity = accAddressInfo.ShippingCity;
            con.MailingState = accAddressInfo.ShippingState;
            con.MailingPostalCode =
            accAddressInfo.ShippingPostalCode;
            con.MailingCountry = accAddressInfo.ShippingCountry;
            con.OtherStreet = accAddressInfo.BillingStreet;
            con.OtherCity = accAddressInfo.BillingCity;
            con.OtherState = accAddressInfo.BillingState;
            con.OtherPostalCode = accAddressInfo.BillingPostalCode;
            con.OtherCountry = accAddressInfo.BillingCountry;
        }
    }
   
    } */
    
    public static void createContact(List<Contact>conList){
        
        Set<Id> accIds=new Set<Id>();
        for(Contact con:conList){
            if(con.AccountId!=null){
                accIds.add(con.AccountId);
            }
        }
        
        Map<Id,Account> accMapRec=new Map<Id,Account>([select Id,Name,Active__c from Account where Id IN :accIds]);
        
        for(Contact con:conList){
            Account accList=accMapRec.get(con.AccountId);
            if(accList.Active__c=='No'){
                con.addError('You can not create an Contact under the account that is Not Active');   
            }
        }
        
        
    }
}