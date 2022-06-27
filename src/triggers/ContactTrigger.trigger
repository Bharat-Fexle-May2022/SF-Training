trigger ContactTrigger on Contact (before insert) {
    if (trigger.isBefore && trigger.isInsert) {
        ContactTriggerHelper.ValidateContact(trigger.new);
    }
}