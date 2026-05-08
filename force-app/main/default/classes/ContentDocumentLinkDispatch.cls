public class ContentDocumentLinkDispatch {
    public static void dispatch(System.TriggerOperation operationType) {

        switch on operationType {
            when AFTER_INSERT {
                ContentDocumentLinkTriggerHandler.handleAfterInsert(Trigger.new);
            }
            when else { }
        }
    }
}