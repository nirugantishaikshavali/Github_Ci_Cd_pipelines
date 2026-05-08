public class ContentVersionHandler {
    
    public static void AFTER_INSERT(List<ContentVersion>newList){
        ContentVersionHelper.handleAfterInsert(newList);
        
    }

}