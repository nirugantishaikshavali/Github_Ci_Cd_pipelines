public class OpportnuityContentDocumentLinkDispatch {
    public static void dispatch(System.TriggerOperation operationType,List<ContentDocumentLink>newList){
        switch on operationType{
            when BEFORE_INSERT{
            OpportunityContentDocumentLinkHandler.handleBeforeInsert(newList);
            }
            when AFTER_INSERT{
            OpportunityContentDocumentLinkHandler.handleAfterInsert(newList);
            }
            WHEN ELSE{
                
            }
        }
        
    }

}