trigger Day13_TriggerForAccount on Account (before insert) {
    if (Trigger.isBefore) {
        // if (Trigger.isDelete) {
        //     if (Day13_StaticAndInstanceMethods.firstRun) {
        //         Trigger.old[0].addError('Before Account Delete Error');
        //         Day13_StaticAndInstanceMethods.firstRun = false;
        //     } 
        // }

        if (Trigger.isInsert) {
            TriggerAccountHelper.setAccountStatus(Trigger.new);
        }
    }
}