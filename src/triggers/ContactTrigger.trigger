trigger ContactTrigger on Contact (before insert) {
    if (Trigger.isBefore) {
        if (Trigger.isInsert) {
            // ContactTriggerHelper.ValidateContact(Trigger.new);
            ContactTriggerHelper.setContactStatus(Trigger.new);            
        }
    }
}