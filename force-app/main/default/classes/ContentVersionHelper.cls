public class ContentVersionHelper {
    
 public static void handleAfterInsert(List<ContentVersion> newList){

        // STEP 1: Filter only Account related files
        Map<Id, ContentVersion> cvMap = new Map<Id, ContentVersion>();

        for(ContentVersion cv : newList){
            if(cv.FirstPublishLocationId != null &&
               String.valueOf(cv.FirstPublishLocationId).startsWith('001')){

                cvMap.put(cv.Id, cv);
            }
        }

        if(cvMap.isEmpty()){
            return;
        }

        // STEP 2: Create ContentDistribution (Public Link)
        List<ContentDistribution> distList = new List<ContentDistribution>();

        for(ContentVersion cv : cvMap.values()){
            ContentDistribution cd = new ContentDistribution();
            cd.ContentVersionId = cv.Id;
            cd.Name = cv.Title;
            cd.PreferencesAllowViewInBrowser = true;
            cd.PreferencesAllowOriginalDownload = true;
            cd.PreferencesNotifyOnVisit = false;

            distList.add(cd);
        }

        insert distList;

        // STEP 3: Query back to get public URL
        Map<Id, ContentDistribution> distMap = new Map<Id, ContentDistribution>(
            [SELECT Id, ContentDownloadUrl, ContentVersionId 
             FROM ContentDistribution 
             WHERE Id IN :distList]
        );

        // STEP 4: Create PublicFileLinks__c records
        List<PublicFileLinks__c> recordsToInsert = new List<PublicFileLinks__c>();

        for(ContentDistribution cd : distMap.values()){

            ContentVersion cv = cvMap.get(cd.ContentVersionId);

            if(cv != null){
                PublicFileLinks__c rec = new PublicFileLinks__c();
                rec.Account__c = cv.FirstPublishLocationId;
                rec.Name = cv.Title;
                rec.Link_to_File__c = cd.ContentDownloadUrl;

                recordsToInsert.add(rec);
            }
        }

        if(!recordsToInsert.isEmpty()){
            insert recordsToInsert;
        }
    }
}