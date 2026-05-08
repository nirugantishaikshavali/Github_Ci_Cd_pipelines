public class FetchAccRecords {

    public static List<Account> AccountRecords() {

        List<Account> alist = [
            SELECT Id, Name, Rating
            FROM Account
            LIMIT 10
        ];

        return alist;
    }

    public static void DisplayRecords() {

        List<Account> accreclist = AccountRecords();

        for (Account acc : accreclist) {
            System.debug(
                'Account Name: ' + acc.Name +
                ', Account ID: ' + acc.Id +
                ', Ratings: ' + acc.Rating
            );
        }
    }
}