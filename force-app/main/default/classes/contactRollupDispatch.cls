public class contactRollupDispatch {
    public static void dispatch(System.TriggerOperation operationType){
        switch on operationType {
            when AFTER_INSERT {
                contactRollupHandler.AfterInsertHandler((Map<Id,Contact>)Trigger.newMap);
            }
            
            WHEN AFTER_DELETE{
                contactRollupHandler.AfterDeleteHandler((Map<Id,Contact>)Trigger.oldMap);
            }

            WHEN AFTER_UNDELETE{
                contactRollupHandler.AfterUnDeleteHandler((Map<Id,Contact>)Trigger.newMap);
            }
            
             WHEN AFTER_UPDATE{
                contactRollupHandler.AfterUpdateHandler((Map<Id,Contact>)Trigger.newMap,(Map<Id,Contact>)Trigger.oldMap);
            }
            
        }
    }
}