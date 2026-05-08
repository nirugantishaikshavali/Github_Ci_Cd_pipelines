trigger ContentDocumentLinkTrigger on ContentDocumentLink (after insert) {
    //ContentDocumentLinkDispatch.dispatch(Trigger.operationType);
    FileLinkHandler.linkFileToAccount(Trigger.new);
}