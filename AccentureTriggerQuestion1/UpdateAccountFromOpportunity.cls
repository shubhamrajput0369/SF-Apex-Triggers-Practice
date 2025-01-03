public without sharing class UpdateAccountFromOpportunity{
    public static void updateAccountDescription(List<Opportunity> newOppList, Map<Id,Opportunity> oldOppMap, Boolean isInsertOperation){
        Map<Id,String> accIdVsOppNameMap;

        if(isInsertOperation){
            if(newOppList != null){
                accIdVsOppNameMap = accountUpdateLogic(newOppList);
            }
        }
        else{
            if(newOppList != null && oldOppMap != null){
                List<Opportunity> oppList = new List<Opportunity>();
                for(Opportunity opp: newOppList){
                    if(opp.Amount != oldOppMap.get(opp.Id).Amount){
                        oppList.add(opp);
                    }
                }
                accIdVsOppNameMap = accountUpdateLogic(oppList);
            }
        }

        

        if(accIdVsOppNameMap != null){
            List<Account> accList = [SELECT Id, Description FROM Account WHERE Id IN : accIdVsOppNameMap.keyset() WITH USER_MODE];
            for(Account acc: accList){
                acc.Description = accIdVsOppNameMap.get(acc.Id);
            }

            if(accList.size()>0 || accList != null){
                Database.update(accList);
            }
        }
    }

    public static Map<Id, String> accountUpdateLogic(List<Opportunity> oppList){
        Map<Id,String> accIdVsOppNameMap = new Map<Id,String>();
        Decimal maxAmount = 0;
        
        for(Opportunity opp: oppList){
            if(opp.AccountId != null){
                List<Opportunity> filteredOppList = [SELECT Id, AccountId, Amount, Name FROM Opportunity WHERE AccountId =: opp.AccountId WITH USER_MODE];
                if(filteredOppList != null){
                    for(Opportunity fopp: filteredOppList){
                        if(fopp.amount > maxAmount){
                            maxAmount = fopp.amount;
                            if(accIdVsOppNameMap.containsKey(fopp.AccountId)){
                                accIdVsOppNameMap.put(fopp.AccountId, fopp.Name);
                            }
                            else{
                                accIdVsOppNameMap.put(fopp.AccountId, fopp.Name);
                            }
                        }
                    }
                }
            }
        }
        System.debug('### accIdVsOppNameMap ==> '+accIdVsOppNameMap);
        return accIdVsOppNameMap;
    }
}