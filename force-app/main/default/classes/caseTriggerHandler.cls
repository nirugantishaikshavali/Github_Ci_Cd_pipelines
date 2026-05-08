public class caseTriggerHandler {
    public static void afterInsertHandler(List<Case>caseList){
        caseTriggerHelper.createNewCaseRecord(caseList);
    }
}