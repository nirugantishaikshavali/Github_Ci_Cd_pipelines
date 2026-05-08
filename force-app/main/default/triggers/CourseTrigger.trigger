trigger CourseTrigger on Course__c (before insert) {
CourseTriggerHandler.run(Trigger.new);
}