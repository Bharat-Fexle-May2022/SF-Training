trigger TriggerAccount on Account (before insert, after insert, after delete) {

    if (Trigger.isAfter) {
        if (Trigger.isInsert) {
            TriggerAccountHelper.createAccountEmail(Trigger.new);
        }

        if (Trigger.isDelete) {
            TriggerAccountHelper.deleteAccountMail(Trigger.old);
        }
    }

    if (Trigger.isBefore) {
        if (Trigger.isInsert) {
            TriggerAccountHelper.prefixAccountNumber(Trigger.new);
        }
    }

    TriggerAccountHelper.testTriggerEvents(Trigger.new, Trigger.old);

}