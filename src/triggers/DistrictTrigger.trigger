trigger DistrictTrigger on District__c (after insert, after update, after delete) {
    if(Trigger.isAfter) {
        if (Trigger.isDelete) {
            DistrictTriggerHelper.updateCountryAndStateWhenDistrictIsDeleted(Trigger.old);
        }
        if (Trigger.isInsert) {
            DistrictTriggerHelper.updateCountryAndStateWhenDistrictIsInserted(Trigger.new);
        }
        if (Trigger.isUpdate) {
            DistrictTriggerHelper.updateCountryStateAndDistrictWhenDistrictIsUpdated(Trigger.new, Trigger.old);
        }
    }
}