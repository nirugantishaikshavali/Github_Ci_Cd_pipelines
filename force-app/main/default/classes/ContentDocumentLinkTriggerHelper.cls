public class ContentDocumentLinkTriggerHelper {

    public static void createPublicLinks(List<ContentDocumentLink> newList){
        System.debug('🔥 HELPER CALLED: newList size = ' + newList.size());


        //Step 1: Collect Account Ids + ContentDocumentIds
        Set<Id> accountIds = new Set<Id>();
        Set<Id> contentDocumentIds = new Set<Id>();

        for(ContentDocumentLink cdl : newList){
            System.debug('LinkedEntityId = ' + cdl.LinkedEntityId + ' ContentDocumentId = ' + cdl.ContentDocumentId);


            //Only if file is linked to Account
            if(cdl.LinkedEntityId != null && String.valueOf(cdl.LinkedEntityId).startsWith('001')){

                accountIds.add(cdl.LinkedEntityId);
                contentDocumentIds.add(cdl.ContentDocumentId);
            }
        }

        if(accountIds.isEmpty() || contentDocumentIds.isEmpty()){
            return;
        }

        //Step 2: Fetch Latest ContentVersion for those ContentDocuments
        Map<Id, Id> docIdToLatestVersionId = new Map<Id, Id>();

        for(ContentVersion cv : [
            SELECT Id, ContentDocumentId, Title, FileExtension
            FROM ContentVersion
            WHERE ContentDocumentId IN :contentDocumentIds
            AND IsLatest = true
        ]){
            docIdToLatestVersionId.put(cv.ContentDocumentId, cv.Id);
        }

        if(docIdToLatestVersionId.isEmpty()){
            return;
        }

        //Step 3: Create ContentDistribution Records
        List<ContentDistribution> distList = new List<ContentDistribution>();

        for(Id docId : docIdToLatestVersionId.keySet()){

            ContentDistribution dist = new ContentDistribution();
            dist.ContentVersionId = docIdToLatestVersionId.get(docId);
            dist.Name = 'Public Link - ' + docId;

            //Important Settings
            dist.PreferencesAllowViewInBrowser = true;
            dist.PreferencesAllowOriginalDownload = true;
            dist.PreferencesNotifyOnVisit = false;

            distList.add(dist);
        }

        insert distList;

        //Step 4: Fetch inserted distributions with Public URL
        Map<Id, ContentDistribution> versionIdToDist = new Map<Id, ContentDistribution>();

        for(ContentDistribution cd : [
            SELECT Id, ContentVersionId, ContentDownloadUrl, DistributionPublicUrl
            FROM ContentDistribution
            WHERE Id IN :distList
        ]){
            versionIdToDist.put(cd.ContentVersionId, cd);
        }

        //Step 5: Create PublicFileLinks__c Records
        List<PublicFileLinks__c> publicLinksToInsert = new List<PublicFileLinks__c>();

        for(ContentDocumentLink cdl : newList){

            if(cdl.LinkedEntityId != null && String.valueOf(cdl.LinkedEntityId).startsWith('001')){

                Id versionId = docIdToLatestVersionId.get(cdl.ContentDocumentId);

                if(versionId != null && versionIdToDist.containsKey(versionId)){

                    ContentDistribution dist = versionIdToDist.get(versionId);

                    PublicFileLinks__c pfl = new PublicFileLinks__c();
                    pfl.Account__c = cdl.LinkedEntityId;

                    //Your custom field name (recommended)
                    pfl.Link_to_File__c = dist.ContentDownloadUrl;

                    publicLinksToInsert.add(pfl);
                }
            }
        }

        if(!publicLinksToInsert.isEmpty()){
            insert publicLinksToInsert;
        }
    }
}