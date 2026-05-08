public class CourseTriggerHandler {
    public static void run(List<Course__c>newRecords){
        List<Course__c>courseList=[Select Id,Name,Price__c,Start_Date__c 
                                   from 
                                   		Course__c
                                  Where 
                                   Id IN :newRecords];
        System.debug('courseList'+courseList);
        
    }

}