trigger DeloitteInterviewQuestion1 on Account (after insert, after update) {
    if(Trigger.isInsert && Trigger.isAfter){
        DeloitteTriggerQuestion1.updateContactOnAccountUpdate(Trigger.new,Trigger.oldMap, true);
    }
    if(Trigger.isUpdate && Trigger.isAfter){
        DeloitteTriggerQuestion1.updateContactOnAccountUpdate(Trigger.new,Trigger.oldMap, false);
    }
}