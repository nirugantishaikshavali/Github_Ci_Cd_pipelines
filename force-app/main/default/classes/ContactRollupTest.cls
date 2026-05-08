@isTest
public class ContactRollupTest {
    
    @testSetup
    static void setupData() {
        // Create Accounts
        List<Account> accList = new List<Account>{
            new Account(Name='Acc1'),
            new Account(Name='Acc2'),
            new Account(Name='Acc3')
        };
        insert accList;
        
        // Create Contacts for Acc1
        List<Contact> conList = new List<Contact>{
            new Contact(LastName='C1', AccountId=accList[0].Id),
            new Contact(LastName='C2', AccountId=accList[0].Id)
        };
        insert conList;
    }
    
    @isTest
    static void testInsertContact() {
        Account acc = [SELECT Id FROM Account WHERE Name='Acc3' LIMIT 1];
        
        Contact c = new Contact(LastName='New', AccountId=acc.Id);
        
        Test.startTest();
        insert c;
        Test.stopTest();
        
        Account result = [SELECT Number_of_Contacts__c FROM Account WHERE Id = :acc.Id];
        System.assertEquals(1, result.Number_of_Contacts__c);
    }
    
    @isTest
    static void testUpdateContactAccountChange() {
        Account acc1 = [SELECT Id FROM Account WHERE Name='Acc1' LIMIT 1];
        Account acc2 = [SELECT Id FROM Account WHERE Name='Acc2' LIMIT 1];
        
        Contact c = [SELECT Id, AccountId FROM Contact WHERE AccountId = :acc1.Id LIMIT 1];
        
        c.AccountId = acc2.Id;
        
        Test.startTest();
        update c;
        Test.stopTest();
        
        Map<Id, Account> accMap = new Map<Id, Account>(
            [SELECT Number_of_Contacts__c FROM Account WHERE Id IN :new List<Id>{acc1.Id, acc2.Id}]
        );
        
        System.assertEquals(1, accMap.get(acc1.Id).Number_of_Contacts__c);
        System.assertEquals(1, accMap.get(acc2.Id).Number_of_Contacts__c);
    }
    
    @isTest
    static void testDeleteContact() {
        Account acc = [SELECT Id FROM Account WHERE Name='Acc1' LIMIT 1];
        Contact c = [SELECT Id FROM Contact WHERE AccountId = :acc.Id LIMIT 1];
        
        Test.startTest();
        delete c;
        Test.stopTest();
        
        Account result = [SELECT Number_of_Contacts__c FROM Account WHERE Id = :acc.Id];
        System.assertEquals(1, result.Number_of_Contacts__c);
    }
    
    @isTest
    static void testUndeleteContact() {
        Account acc = [SELECT Id FROM Account WHERE Name='Acc1' LIMIT 1];
        Contact c = [SELECT Id FROM Contact WHERE AccountId = :acc.Id LIMIT 1];
        
        delete c;
        
        Test.startTest();
        undelete c;
        Test.stopTest();
        
        Account result = [SELECT Number_of_Contacts__c FROM Account WHERE Id = :acc.Id];
        System.assertEquals(2, result.Number_of_Contacts__c);
    }
}