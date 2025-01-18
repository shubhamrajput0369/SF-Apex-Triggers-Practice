public with sharing class InfosysTriggerQuestion1 {
    public InfosysTriggerQuestion1(List<Case> newCaseList, Map<Id,Case> idVsCaseOldMap, Boolean isInsertOperation) {
        Map<Id,String> conIdVsEmailMap = new Map<Id,String>(); 
        List<Contact> contactToBeInsertedList = new List<Contact>();
        List<Case> caseToBeUpdatedList = new List<Case>();
        List<Case> newlyLinkedCaseToBeUpdatedList = new List<Case>();
        

        if(newCaseList != NULL){
            for(Case caseObj : newCaseList){
                if(caseObj.suppliedEmail__c != NULL){
                    conIdVsEmailMap.put(caseObj.Id, caseObj.suppliedEmail__c);
                }
            }
            if(!conEmailSet.isEmpty()){
                List<Contact> conList = [SELECT Id, email FROM Contact WHERE email IN : conIdVsEmailMap.values() WITH USER_MODE];
            }
            if(!conList.isEmpty() && !conIdVsEmailMap.isEmpty()){
                for(Case caseObj: newCaseList){
                    Boolean flag = false;
                    for(Contact conObj : conList){
                        if(caseObj.suppliedEmail__c == conObj.Email){
                            caseObj.Contact = conObj.Id;
                            flag = true;
                            caseToBeUpdatedList.add(caseObj);
                        }
                    }
                    if(!flag){
                        Contact con = new Contact();
                        con.LastName =  caseObj.suppliedEmail__c;
                        con.Email =  caseObj.suppliedEmail__c;
                        contactToBeInsertedList.add(con);
                        newlyLinkedCaseToBeUpdatedList.add(caseObj);
                    }
                }
            }
            update caseToBeUpdatedList;
            insert contactToBeInsertedList;
            for(Case case : newlyLinkedCaseToBeUpdatedList){
                for(Contact con : contactToBeInsertedList){
                    case.contact = con.Id;
                }
            }
            update newlyLinkedCaseToBeUpdatedList;
        }
    }

    public linkContact(Case caseObj){
        if(suppliedEmail != NULL){
            List<Contact> conList = [SELECT Id, email FROM Contact WHERE email = caseObj.suppliedEmail];
            caseObj.Id = conList.Id;
        }
        return caseObj;
    }
}



//Case - Created => Contact (EmailContact == SuppliedEmailCase) => If (exist) Link Existing contact to Case else Create Contact with suppliedEmail and Link to Case.
//Case - Updated => Contact (EmailContact == SuppliedEmailCase) => If (exist) Link Existing contact to Case else Create Contact with suppliedEmail and Link to Case.