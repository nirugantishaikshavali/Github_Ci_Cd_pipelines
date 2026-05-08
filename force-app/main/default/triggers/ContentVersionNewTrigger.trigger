trigger ContentVersionNewTrigger on ContentVersion (before insert) {
    
 Set<Id> contentVersionIds = new Set<Id>();
    Set<Id> contentDocumentIds = new Set<Id>();

    // Step 1: Collect IDs
    for(ContentVersion cv : Trigger.New){
        contentVersionIds.add(cv.Id);
        contentDocumentIds.add(cv.ContentDocumentId);
    }

    // Step 2: Find where file is attached
    List<ContentDocumentLink> links = [
        SELECT Id, ContentDocumentId, LinkedEntityId
        FROM ContentDocumentLink
        WHERE ContentDocumentId IN :contentDocumentIds
    ];

    Set<Id> accountIds = new Set<Id>();
    Map<Id, Id> docToAccountMap = new Map<Id, Id>();

    // Step 3: Filter only Account
    for(ContentDocumentLink link : links){
        if(link.LinkedEntityId.getSObjectType() == Account.SObjectType){
            accountIds.add(link.LinkedEntityId);
            docToAccountMap.put(link.ContentDocumentId, link.LinkedEntityId);
        }
    }

    // Step 4: Get latest ContentVersion
    List<ContentVersion> versions = [
        SELECT Id, ContentDocumentId
        FROM ContentVersion
        WHERE ContentDocumentId IN :docToAccountMap.keySet()
        AND IsLatest = true
    ];

    List<ContentDistribution> distList = new List<ContentDistribution>();

    // Step 5: Create public links
    for(ContentVersion cv : versions){
        ContentDistribution dist = new ContentDistribution();
        dist.ContentVersionId = cv.Id;
        dist.Name = 'Public Link - ' + cv.Id;
        dist.PreferencesAllowViewInBrowser = true;
        dist.PreferencesAllowOriginalDownload = true;
        dist.PreferencesNotifyOnVisit = false;

        distList.add(dist);
    }

    if(!distList.isEmpty()){
        insert distList;
    }

}