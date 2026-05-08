trigger opportunityTrigger on Opportunity (before insert) {
    opportunityDispatcher.dispatch(Trigger.operationType);

}