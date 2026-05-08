public class CaseTriggerHelper {

    public static Boolean running = false;

    public static void createNewCaseRecord(List<Case> caseList){

        List<Case> newCaseRecordToInsert = new List<Case>();

        for(Case c : caseList){
            Case caseRecord = new Case(
                Subject = c.Subject,
                ContactId = c.ContactId,
                Status = c.Status,
                Description = c.Description,
                Priority = c.Priority,
                ParentId = c.Id,
                Origin = c.Origin
            );
            newCaseRecordToInsert.add(caseRecord);
        }
        //running=true;

        List<Database.SaveResult> saveResult =
            Database.insert(newCaseRecordToInsert, false);

        List<System_Event__c> eventList = new List<System_Event__c>();

        for(Integer i = 0; i < saveResult.size(); i++){

            Database.SaveResult sr = saveResult[i];

            if(!sr.isSuccess()){

                String msg = '';
                for(Database.Error err : sr.getErrors()){
                    msg += err.getStatusCode() + ' : ' + err.getMessage() + ' ';
                }

                // ✅ Add event record into list (Bulk Safe)
                eventList.add(
                    Logging.prepareDmlError(
                        'Error while creating Child Case',
                        'Apex Class',
                        'DMLException',
                        msg,
                        caseList[i].Id
                    )
                );
            }
        }

        if(!eventList.isEmpty()){
            insert eventList;
        }
    }
}