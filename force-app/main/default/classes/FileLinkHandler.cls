public class FileLinkHandler {

    public static void linkFileToAccount(List<ContentDocumentLink> newList){

        Set<Id> taskIds = new Set<Id>();
        Set<Id> eventIds = new Set<Id>();
        Set<Id> caseIds = new Set<Id>();

        // Identify object types
        for(ContentDocumentLink cdl : newList){

            if(cdl.LinkedEntityId.getSObjectType() == Task.SObjectType){
                taskIds.add(cdl.LinkedEntityId);
            }

            if(cdl.LinkedEntityId.getSObjectType() == Event.SObjectType){
                eventIds.add(cdl.LinkedEntityId);
            }

            if(cdl.LinkedEntityId.getSObjectType() == Case.SObjectType){
                caseIds.add(cdl.LinkedEntityId);
            }
        }

        Map<Id,Task> taskMap = new Map<Id,Task>(
            [SELECT Id, WhatId FROM Task WHERE Id IN :taskIds]
        );

        Map<Id,Event> eventMap = new Map<Id,Event>(
            [SELECT Id, WhatId FROM Event WHERE Id IN :eventIds]
        );

        Map<Id,Case> caseMap = new Map<Id,Case>(
            [SELECT Id, AccountId FROM Case WHERE Id IN :caseIds]
        );

        List<ContentDocumentLink> newLinks = new List<ContentDocumentLink>();

        for(ContentDocumentLink cdl : newList){

            Id accountId;

            // Task
            if(taskMap.containsKey(cdl.LinkedEntityId)){
                Task t = taskMap.get(cdl.LinkedEntityId);

                if(t.WhatId != null && 
                   t.WhatId.getSObjectType() == Account.SObjectType){
                    accountId = t.WhatId;
                }
            }

            // Event
            if(eventMap.containsKey(cdl.LinkedEntityId)){
                Event e = eventMap.get(cdl.LinkedEntityId);

                if(e.WhatId != null && 
                   e.WhatId.getSObjectType() == Account.SObjectType){
                    accountId = e.WhatId;
                }
            }

            // Case
            if(caseMap.containsKey(cdl.LinkedEntityId)){
                accountId = caseMap.get(cdl.LinkedEntityId).AccountId;
            }

            if(accountId != null){
                ContentDocumentLink newLink = new ContentDocumentLink();
                newLink.ContentDocumentId = cdl.ContentDocumentId;
                newLink.LinkedEntityId = accountId;
                newLink.ShareType = 'V';
                newLink.Visibility = 'AllUsers';

                newLinks.add(newLink);
            }
        }

        if(!newLinks.isEmpty()){
            insert newLinks;
        }
    }
}