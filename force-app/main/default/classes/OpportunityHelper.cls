public with sharing class OpportunityHelper {

    public static void calculateOpportunityAmount(
        List<Opportunity> oppList,
        Map<Id, Opportunity> oldMap
    ) {

        Set<Id> accIds = new Set<Id>();

        // From current records (insert/update/undelete OR delete uses old list)
        for (Opportunity opp : oppList) {
            if (opp.AccountId != null) {
                accIds.add(opp.AccountId);
            }
        }

        // From old records (only for update/delete)
        if (oldMap != null) {
            for (Opportunity oldOpp : oldMap.values()) {
                if (oldOpp.AccountId != null) {
                    accIds.add(oldOpp.AccountId);
                }
            }
        }

        if (accIds.isEmpty()) return;

        // Closed Opportunities
        Map<Id, Decimal> closedMap = new Map<Id, Decimal>();
        for (AggregateResult ar : [
            SELECT AccountId, SUM(Amount) total
            FROM Opportunity
            WHERE AccountId IN :accIds
            AND StageName IN ('Closed Won','Closed Lost')
            GROUP BY AccountId
        ]) {
            closedMap.put((Id) ar.get('AccountId'), (Decimal) ar.get('total'));
        }

        // Open Opportunities
        Map<Id, Decimal> openMap = new Map<Id, Decimal>();
        for (AggregateResult ar : [
            SELECT AccountId, SUM(Amount) total
            FROM Opportunity
            WHERE AccountId IN :accIds
            AND StageName NOT IN ('Closed Won','Closed Lost')
            GROUP BY AccountId
        ]) {
            openMap.put((Id) ar.get('AccountId'), (Decimal) ar.get('total'));
        }

        // Prepare Account updates
        List<Account> accList = new List<Account>();

        for (Id accId : accIds) {
            Account acc = new Account();
            acc.Id = accId;

            acc.Sum_of_closed_oppurtunity__c =
                closedMap.containsKey(accId) ? closedMap.get(accId) : 0;

            acc.Sum_of_opened_oppurtunity__c =
                openMap.containsKey(accId) ? openMap.get(accId) : 0;

            accList.add(acc);
        }

        if (!accList.isEmpty()) {
            update accList;
        }
    }
}