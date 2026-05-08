public with sharing class contactController {

    @AuraEnabled(cacheable=true)
    public static List<Contact> getContactList() {
        List<Contact> conList = [
            SELECT Id, Name, FirstName, LastName,
                   Title, Phone, Email, PhotoURL
            FROM Contact
            WHERE PhotoURL != NULL
            LIMIT 10
        ];
        return conList;
    }


    @AuraEnabled(cacheable=true)
    public static List<Contact> getContactListForDataTable() {
        List<Contact> conList = [
            SELECT Id, Name, FirstName, LastName,
                   Title, Phone, Email, Picture__c,Rank__c,AccountId,Account.Name
            FROM Contact
            WHERE AccountId != NULL
            WITH USER_MODE
            LIMIT 10
        ];
        return conList;
    }
    
    @AuraEnabled(cacheable=true)
    public static List<Contact>getContactBasedOnAccount(String accountId){
        List<Contact> conList=[
            select Id,Name,FirstName,LastName,Title,Phone,Email,Picture__c,Rank__c,AccountId,Account.Name,
            LeadSource from Contact where AccountId= :accountId WITH USER_MODE LIMIT 10
        ];
        return conList;
    }
}