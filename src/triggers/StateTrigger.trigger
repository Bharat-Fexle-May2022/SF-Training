trigger StateTrigger on State__c (after insert, after update, after delete) {
    if (Trigger.isAfter) {
        if (Trigger.isDelete) {
            StateTriggerHelper.updateCountryWhenStateIsDeleted(Trigger.old);
        }
        if (Trigger.isUpdate) {
            StateTriggerHelper.updateCountryAndStateWhenStateIsUpdated(Trigger.new, Trigger.old);            
        }
        if (Trigger.isInsert) {
            StateTriggerHelper.updateCountryWhenStateIsInserted(Trigger.new);
        }
    }
}