public class Logging {

    // returns record (does NOT insert)
    public static System_Event__c prepareDmlError(
        String title,
        String componentType,
        String exceptionType,
        String message,
        Id relatedRecordId
    ){
        System_Event__c eventRec = new System_Event__c();
        eventRec.Title__c = title;
        eventRec.Component_Type__c = componentType;
        eventRec.Exception_Type__c = exceptionType;
        eventRec.Message__c = message;
        eventRec.Related_Record_Id__c = relatedRecordId;
        eventRec.User__c = UserInfo.getUserId();

        return eventRec;
    }
}