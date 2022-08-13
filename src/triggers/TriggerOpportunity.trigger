trigger TriggerOpportunity on Opportunity (after insert, after update) {

    if (Trigger.isAfter) {
        if (Trigger.isInsert || Trigger.isUpdate) {
            Set<Opportunity> setOfOpportunity = new Set<Opportunity>();
            if (Trigger.new != null) {
                for (Opportunity opp : Trigger.new) {
                    if (opp.StageName == 'Shipped To Customer' || opp.StageName == 'Return to HQ' || opp.StageName == 'Return to Customer') {
                        setOfOpportunity.add(opp);
                    }
                }
            }
            
            if(!setOfOpportunity.isEmpty())
            {
                OpportunityTriggerHelper.insertAndUpdateOpportunity(setOfOpportunity);
            }
        }
    }
}