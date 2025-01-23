public with sharing class EYTriggerQuestion1 {
    public static createCaseonCreateTaskEnable(List<Case> newCaseList, Map<Id,Case> oldCaseMap, Boolean isInsertOperation){
        try{
            Set<Account> accountsOfCaseSet = new Set<Case>();

            if(!newCaseList.isEmpty()){
                for(Case cs : newCaseList){
                    if(!isInsertOperation){
                        if(cs.CreateTask__c == true && oldCaseMap.get(cs.Id) == false){
                            accountsOfCaseSet.add(cs.Account);
                        }
                    }
                    else{
                        if(cs.CreateTask__c == true){
                            accountsOfCaseSet.add(cs.Account);
                        }
                    }
                }
            }

            List<Contact>  primaryContactList = [SELECT Id, PrimaryContact FROM Contact WHERE PrimaryContact = true AND Id IN : accountsOfCaseSet WITH USER_MODE];
            List<Task> taskListToBeInserted;
            
            if(!primaryContactList.isEmpty()){
                for(Contact cont : primaryContactList){
                    Task task = new Task();
                    task.Name = 'Primary Follow Up Task';
                    task.Contact = cont.Id;
                    taskListToBeInserted.add(task);
                }
            }

            if(!taskListToBeInserted.isEmpty()){
                insert taskListToBeInserted;
            }
        }
        catch(Exception ex){
            System.out.println(ex.getMessage());
        }
    }
}

// Scenario Question -
// Case Inserted/Updated => CreateTask = true => fetch Account of Case 
// => Fetch Primary Contact of that Account => Create a Case link with this Primary Contact

/*  Completion Time - 00:28.52.93
                      hr:min:sec
*/