public class ContactBatchClassSchedulable implements System.Schedulable,
Database.AllowsCallouts{
    
    public void execute(System.SchedulableContext sc){
        ContactBatchClass batch=new ContactBatchClass();
        Id jobId=Database.executeBatch(batch,200);


    }

}