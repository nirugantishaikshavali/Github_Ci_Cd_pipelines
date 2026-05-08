public with sharing class PublishPlatformEventCallback 
    implements EventBus.EventPublishSuccessCallback,
               EventBus.EventPublishFailureCallback {

    // Success Callback
    public void onSuccess(EventBus.SuccessResult result){
        List<String> eventUUIDList = result.getEventUuids();
        insertTask(eventUUIDList, true);
    }

    // Failure Callback
    public void onFailure(EventBus.FailureResult result){
        List<String> eventUUIDList = result.getEventUuids();
        insertTask(eventUUIDList, false);
    }

    // Common Method to Create Task
    public void insertTask(List<String> eventUUIDList, Boolean isSuccess){

        // Join UUIDs into a single string
        String eventUUIDString = '';
        for(String eventUUID : eventUUIDList){
            eventUUIDString += eventUUID + ', ';
        }

        Task taskDetail = new Task();

        if(isSuccess){
            taskDetail.Subject = 'Platform Event Published Successfully';
            taskDetail.Description =
                'Total Platform Events Published Successfully: ' +
                eventUUIDList.size() +
                '\nEvent UUIDs: ' +
                eventUUIDString;
        } else {
            taskDetail.Subject = 'Platform Event Publishing Failed';
            taskDetail.Description =
                'Total Platform Events Failed: ' +
                eventUUIDList.size() +
                '\nEvent UUIDs: ' +
                eventUUIDString;
        }

        taskDetail.ActivityDate = Date.today();

        // Safer User Query
        List<User> users = [
            SELECT Id 
            FROM User 
            WHERE Username = 'nirugantishaikshavali78190@agentforce.com'
            LIMIT 1
        ];

        if(!users.isEmpty()){
            taskDetail.OwnerId = users[0].Id;
        }

        try {
            insert taskDetail;
        } catch (Exception ex) {
            System.debug(LoggingLevel.ERROR, 
                'Task Insertion Failed: ' + ex.getMessage());
        }
    }
}