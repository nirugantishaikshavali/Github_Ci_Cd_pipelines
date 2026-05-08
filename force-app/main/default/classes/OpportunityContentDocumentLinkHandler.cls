public class OpportunityContentDocumentLinkHandler {
    public static void handleBeforeInsert(List<ContentDocumentLink> newList){
        OpportunityContentDocumentLinkHelper.validateOpportunityStage(newList);
    }
    public static void handleAfterInsert(List<ContentDocumentLink> newList){
        OpportunityContentDocumentLinkHelper.createPublicLinks(newList);
    }
    

}