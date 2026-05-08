public class ContactDispatch {
    public static void dispatch(System.TriggerOperation operationType){
        Switch on operationType{
            when AFTER_INSERT{
                contactHandler.handleAfterInsert(Trigger.new);
            }
             when AFTER_DELETE{
                contactHandler.handleAfterDelete(Trigger.old);
            }
            
            when AFTER_UNDELETE{
                 contactHandler.handleUndelete(Trigger.new);
            }
            
            when AFTER_UPDATE{
                contactHandler.handleAfterUpdate((Map<Id,Contact>)trigger.newMap,(Map<Id,Contact>)trigger.oldMap);
   
            }
        }
        
    } 

}