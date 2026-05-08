public class ContactBatchClass implements Database.Batchable<sObject> {
    
    public Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator(
            [SELECT Id, Name, Email FROM Contact]
        );
    }
    
    public void execute(Database.BatchableContext BC, List<Contact> contactList){
        System.debug('Processing Contacts');
    }
    
    public void finish(Database.BatchableContext BC){
        System.debug('Contact Batch Finished');
    }
}