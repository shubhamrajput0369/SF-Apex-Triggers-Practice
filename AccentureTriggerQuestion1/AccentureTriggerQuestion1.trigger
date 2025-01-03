trigger AccentureTriggerQuestion1 on Opportunity (after insert, after update) {
    if(Trigger.isInsert){
        UpdateAccountFromOpportunity.updateAccountDescription(Trigger.new, Trigger.oldMap, true);
    }

    if(Trigger.isAfter){
        UpdateAccountFromOpportunity.updateAccountDescription(Trigger.new, Trigger.oldMap, false);
    }
}