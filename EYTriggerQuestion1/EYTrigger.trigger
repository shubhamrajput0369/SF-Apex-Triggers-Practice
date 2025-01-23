trigger EYTrigger on SOBJECT (After insert, AFter update) {

    if(Trigger.after && Trigger.insert){
        EYTriggerQuestion1.createCaseonCreateTaskEnable(Trigger.new, NULL, true);
    }

    if(Trigger.after && Trigger.update){
        EYTriggerQuestion1.createCaseonCreateTaskEnable(Trigger.new, Trigger.oldMap, false);
    }
}

/*  Completion Time - 00:28.52.93
                      hr:min:sec
*/