public without sharing class DeloitteTriggerQuestion1 {
    updateContactOnAccountUpdate(List<Account> accountObjList, Map<Id,Account> idVsAccountOldMap, Boolean isInsertOperation){
        //Insert Operation Logic
        if(!isInsertOperation){
            for(Integer i=0; i<accountObjList.size(); i++){
                if(accountObjList.[i].Country == idVsAccountOldMap.get(accountObjList.[i].Id).Country){
                    accountObjList.remove(accountObjList.[i]);
                }
            }
        }

        List<Contact> relatedContactList;
        if(!accountObjList.isEmpty()){

            //Preparing Account Id, Contact List Map
            Map<Id,List<Contact>> accIdVsContactListMap = new Map<Id,List<Contact>>();
            for(Account acc : accountObjList){
                if(acc.Id != null){
                    accIdVsContactListMap.put(acc.Id, relatedContactList);
                }
            }

            //Adding Contacts to respective contact list of AccountId
            for(Account acc: accountObjList){
                List<Contact> conList = [SELECT Id, AccountCountry, AccountId FROM Contact WHERE AccountId = acc.Id WITH SECURITY_ENFORCED];
                for(Contact con: conList){
                    accIdVsContactListMap.get(acc.Id).add(con.Id);
                }
            }

            //Update Contacts AccountCountry filed with repsective Account Country field 
            List<Contact> toBeUpdatedContactList;
            for(Account accObj : accountObjList){
                for(Contact conObj: accIdVsContactListMap.get(acc.Id)){
                    conObj.AccountCountry = accObj.Country;
                    toBeUpdatedContactList.add(conObj);
                }
            }

            //Update list of contact
            if(!toBeUpdatedContactList.isEmpty()){
                update toBeUpdatedContactList;
            }
            
        }

    }
}