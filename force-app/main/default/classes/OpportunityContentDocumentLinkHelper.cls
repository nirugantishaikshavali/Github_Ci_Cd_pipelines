public class OpportunityContentDocumentLinkHelper {

    /*
     * BEFORE INSERT
     * Validate that Opportunity Stage = Closed Won
     */
    public static void validateOpportunityStage(
        List<ContentDocumentLink> newList
    ) {

        Set<Id> oppIds = new Set<Id>();

        // Step 1: Collect Opportunity Ids
        for (ContentDocumentLink cdl : newList) {

            if (cdl.LinkedEntityId != null &&
                cdl.LinkedEntityId.getSObjectType() 
                    == Opportunity.SObjectType) {

                oppIds.add(cdl.LinkedEntityId);
            }
        }

        if (oppIds.isEmpty()) {
            return;
        }

        // Step 2: Query Opportunities
        Map<Id, Opportunity> oppMap = new Map<Id, Opportunity>(
            [SELECT Id, StageName
             FROM Opportunity
             WHERE Id IN :oppIds]
        );

        // Step 3: Validate
        for (ContentDocumentLink cdl : newList) {

            if (cdl.LinkedEntityId != null &&
                oppMap.containsKey(cdl.LinkedEntityId)) {

                Opportunity opp = oppMap.get(cdl.LinkedEntityId);

                if (opp.StageName != 'Closed Won') {
                    cdl.addError(
                        'File can be uploaded only for Closed Won Opportunities.'
                    );
                }
            }
        }
    }


    /*
     * AFTER INSERT
     * Create Public Link (ContentDistribution)
     */
    public static void createPublicLinks(
        List<ContentDocumentLink> newList
    ) {

        Set<Id> contentDocumentIds = new Set<Id>();

        // Step 1: Collect ContentDocumentIds
        for (ContentDocumentLink cdl : newList) {

            if (cdl.LinkedEntityId != null &&
                cdl.LinkedEntityId.getSObjectType() 
                    == Opportunity.SObjectType &&
                cdl.ContentDocumentId != null) {

                contentDocumentIds.add(cdl.ContentDocumentId);
            }
        }

        if (contentDocumentIds.isEmpty()) {
            return;
        }

        // Step 2: Get Latest ContentVersion
        Map<Id, Id> docToVersionMap = new Map<Id, Id>();

        for (ContentVersion cv : [
            SELECT Id, ContentDocumentId
            FROM ContentVersion
            WHERE ContentDocumentId IN :contentDocumentIds
            AND IsLatest = true
        ]) {
            docToVersionMap.put(cv.ContentDocumentId, cv.Id);
        }

        if (docToVersionMap.isEmpty()) {
            return;
        }

        // Step 3: Create ContentDistribution Records
        List<ContentDistribution> distList = 
            new List<ContentDistribution>();

        for (Id docId : docToVersionMap.keySet()) {

            ContentDistribution dist = new ContentDistribution();
            dist.ContentVersionId = docToVersionMap.get(docId);
            dist.Name = 'Public Link - ' + docId;

            // Preferences
            dist.PreferencesAllowViewInBrowser = true;
            dist.PreferencesAllowOriginalDownload = true;
            dist.PreferencesNotifyOnVisit = false;

            distList.add(dist);
        }

        if (!distList.isEmpty()) {
            insert distList;
        }
    }
}