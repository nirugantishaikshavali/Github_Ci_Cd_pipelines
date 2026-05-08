public class AccountHandler {

    // 🔹 BEFORE INSERT
    public void beforeInsert(List<Account> newList) {
        checkDuplicates(newList, null);
    }

    // 🔹 BEFORE UPDATE
    public void beforeUpdate(List<Account> newList, Map<Id, Account> oldMap) {
        checkDuplicates(newList, oldMap);
    }

    // 🔹 AFTER UNDELETE
    public void afterUndelete(List<Account> undeleteList) {
        checkDuplicatesAfterUndelete(undeleteList);
    }

    // 🔥 CORE LOGIC
    private void checkDuplicates(List<Account> newList, Map<Id, Account> oldMap) {

        Set<String> keySet = new Set<String>();
        Map<String, Account> keyToAcc = new Map<String, Account>();

        // 🔸 Internal duplicates (bulk)
        for (Account acc : newList) {

            String key = AccountHelper.generateKey(acc);

            if (keySet.contains(key)) {
                acc.addError('Duplicate in same batch');
            } else {
                keySet.add(key);
                keyToAcc.put(key, acc);
            }
        }

        // 🔸 DB duplicates
        List<Account> existing = [
            SELECT Id, Name, Rating
            FROM Account
            WHERE Name IN :AccountHelper.getNames(newList)
            AND Rating IN :AccountHelper.getRatings(newList)
        ];

        for (Account accDB : existing) {

            String key = AccountHelper.generateKey(accDB);

            if (keyToAcc.containsKey(key)) {

                Account incoming = keyToAcc.get(key);

                // Ignore self update
                if (oldMap != null && incoming.Id == accDB.Id) {
                    continue;
                }

                incoming.addError('Duplicate exists in system');
            }
        }
    }

    // 🔥 UNDELETE LOGIC
    private void checkDuplicatesAfterUndelete(List<Account> listAcc) {

        List<Account> existing = [
            SELECT Id, Name, Rating
            FROM Account
            WHERE Name IN :AccountHelper.getNames(listAcc)
            AND Rating IN :AccountHelper.getRatings(listAcc)
        ];

        for (Account acc : listAcc) {
            String key1 = AccountHelper.generateKey(acc);

            for (Account db : existing) {
                String key2 = AccountHelper.generateKey(db);

                if (key1 == key2 && acc.Id != db.Id) {
                    acc.addError('Duplicate found on undelete');
                }
            }
        }
    }
}