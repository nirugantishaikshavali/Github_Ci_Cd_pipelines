public class ContentDocumentLinkTriggerHandler {
    public static void handleAfterInsert(List<ContentDocumentLink>newList){
        
        //Call helper method
                ContentDocumentLinkTriggerHelper.createPublicLinks(newList);

    }

}