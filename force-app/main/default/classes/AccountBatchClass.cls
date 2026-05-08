public class AccountBatchClass implements Database.Batchable<sObject> {
    
    private String rating;

    public AccountBatchClass(String rating){
        this.rating = rating;
    }
    
    public Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator(
            [SELECT Id, Name FROM Account WHERE Rating = :rating]
        );
    }
    
    public void execute(Database.BatchableContext BC, List<Account> scope){
        System.debug('Processing Accounts');
    }
    
    public void finish(Database.BatchableContext BC){
        System.debug('Account Batch Finished');
        
        // 🔥 Calling another batch here
        ContactBatchClass contactBatch = new ContactBatchClass();
        Database.executeBatch(contactBatch, 200);
    }
}