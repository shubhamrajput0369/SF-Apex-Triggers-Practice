/* Problem Statement - Write a trigger to throw an error message when user tries to create more than one opportunity per account in a single day */

public class OpportunityTriggerHandler{
	public void insertOpportunityValidation(Map<Id,Opportunity> newOppMap){
		Map<Id,Id> oppIdVsAccountIdMap = new Map<Id,Id>();
		Map<Id, List<Opportunity>> accIdVsListOpp = new Map<Id, List<Opportunity>>();

		for(Id opp : newOppMap.keyset()){
			oppIdVsAccountIdMap.put(opp, newOppMap.get(opp).AccountId);
			if(accIdVsListOpp.contains(opp.AccountId)){
				accIdVsListOpp.put(opp.AccountId, opp);
			}
			List<Opportunity> lst 
			accIdVsListOpp.put(opp.AccountId, opp);	
		}

	
        if(oppIdVsAccountIdMap != NULL){
        for(AggregateResult aggrResult : [SELECT AccountId, COUNT(Id) oppCount FROM Opportunity WHERE AccountId IN : oppIdVsAccountIdMap.values() AND CreatedDate = TODAY WITH USER_MODE GROUP BY AccountId]){
        
			Integer oppCount = Integer.valueOf(aggrResult.get('oppCount'));
			String AccountId = String.valueOf(aggrResult.get('AccountId'));
			
			if(aggrResult != NULL && oppCount > 0){
				oppIdVsAccountIdMap.get(AccountId).addError('You can not create more than one opportunity per day on account');
			}
		}
		}
    }
}



