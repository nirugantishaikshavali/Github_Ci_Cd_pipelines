trigger ContentVersionTrigger on ContentVersion (after insert) {
    ContentVersionDispatch.dispatch(Trigger.operationType);
}