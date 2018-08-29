@isTest
private with sharing class AccountsTest {
    @isTest static void test_stampName_integrationTest() {
        Account testAccount = new Account(Name = 'Hello');
        insert testAccount;
        testAccount = [SELECT Id, Name FROM Account WHERE Id =: testAccount.Id];
        System.assertEquals('Mr.Hello', testAccount.Name);
    }

    @isTest static void test_createReminder_integrationTest() {
        Account testAccount = new Account(Name = 'Hello');
        insert testAccount;
        List<Task> taskList = [SELECT Id FROM Task];
        System.assertEquals(1, taskList.size());
    }

    @isTest static void test_createReminder_unitTest() {
        Account testAccount = new Account(Name = 'Hello');
        fflib_ApexMocks mocks = new fflib_ApexMocks();
        fflib_SObjectUnitOfWork mockUow = (fflib_SObjectUnitOfWork) mocks.mock(fflib_SObjectUnitOfWork.class);
        Application.UnitOfWork.setMock(mockUow);
        fflib_SObjectDomain.Test.Database.onInsert(new List<Account> {testAccount});
        fflib_SObjectDomain.triggerHandler(Accounts.class);
        ((fflib_ISObjectUnitOfWork) mocks.verify(mockUow, 1)).registerNew((List<Task>) fflib_Match.anyObject());
    }
}
