trigger InfosysTriggerQuestion1 on Case (after insert, after update) {
    if(Trigger.isAfter && Trigger.isInsert){
        InfosysTriggerQuestion1.updateOrCreateContactOnCase(Trigger.new, Trigger.OldMap);
    }
    if(Trigger.isAfter && Trigger.isInsert){
        InfosysTriggerQuestion1.updateOrCreateContactOnCase(Trigger.new, Trigger.OldMap);
    }
}