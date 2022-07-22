trigger TriggerAccount on Account (before insert, before update, after insert) {

    if (Trigger.isInsert && Trigger.isAfter) {
        TriggerAccountHelper.sendEmailNotification(Trigger.new);
    }

    if (Trigger.isBefore) {
        if (Trigger.isInsert || Trigger.isUpdate) {
            TriggerAccountHelper.prefixAccountNumber(Trigger.new);
            TriggerAccountHelper.testTriggerEvents(Trigger.new, Trigger.old);
        }    
    }
}