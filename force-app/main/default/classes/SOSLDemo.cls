public class SOSLDemo {
    public static void find(String keyword){
        List<List<sObject>> records =[FIND :keyword IN ALL FIELDS RETURNING  Account(Id,Name,Rating,Industry),
         Contact(Id,Name,Email),
         Opportunity(Id,Name,Amount),
         Lead,
         Case];
            System.debug(records.size());
        List<Account> accountRecords=records.get(0);
        System.debug(accountRecords);

    }

}