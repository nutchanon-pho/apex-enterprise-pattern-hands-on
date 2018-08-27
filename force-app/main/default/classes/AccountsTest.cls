@isTest
private with sharing class AccountsTest {
    @isTest static void test_stampName() {
        Account testAccount = new Account(Name = 'Hello');
        insert testAccount;
        testAccount = [SELECT Id, Name FROM Account WHERE Id =: testAccount.Id];
        System.assertEquals('Mr.Hello', testAccount.Name);
    }
}
