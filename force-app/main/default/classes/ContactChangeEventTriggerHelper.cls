public with sharing class ContactChangeEventTriggerHelper {

    public static void afterInsert(List<ContactChangeEvent> contactChangeEventList){

        List<Task> taskList = new List<Task>();

        for(ContactChangeEvent event : contactChangeEventList){

            EventBus.ChangeEventHeader header = event.ChangeEventHeader;
            Id contactId = header.recordIds[0];

            if(header.changeType == 'CREATE'){

                taskList.add(new Task(
                    Subject = 'New Contact Created',
                    WhoId = contactId,
                    Status = 'Not Started',
                    Priority = 'Normal'
                ));
            }

            if(header.changeType == 'UPDATE' && header.changedFields.contains('Email')){

                taskList.add(new Task(
                    Subject = 'Contact Email Updated',
                    WhoId = contactId,
                    Status = 'Not Started',
                    Priority = 'High'
                ));
            }
        }

        if(!taskList.isEmpty()){
            insert taskList;
        }
    }
}