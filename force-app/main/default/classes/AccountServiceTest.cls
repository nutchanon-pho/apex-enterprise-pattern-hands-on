@isTest
private class AccountServiceTest {
    @isTest static void test_updateDescription_integrationTest() {
        Account testAccount = new Account(Name = 'Hello');
        insert testAccount;
        fflib_ISObjectUnitOfWork uow = Application.UnitOfWork.newInstance();
        AccountService.updateDescription(uow, new Set<Id> {testAccount.Id});
        testAccount = [SELECT Id, Description FROM Account WHERE Id = :testAccount.Id];
        System.assertEquals('Test', testAccount.Description);
    }

    @isTest static void test_updateDescription_unitTest() {
        fflib_ApexMocks mocks = new fflib_ApexMocks();
        fflib_SObjectUnitOfWork mockUow = (fflib_SObjectUnitOfWork) mocks.mock(fflib_SObjectUnitOfWork.class);
        Account testAccount = new Account(Id = fflib_IDGenerator.generate(Account.SObjectType), Name = 'Test');
        List<Account> testAccountList = new List<Account> {testAccount};

        AccountsSelector mockAccountsSelector = (AccountsSelector) mocks.mock(AccountsSelector.class);
        mocks.startStubbing();
        mocks.when(mockAccountsSelector.SObjectType()).thenReturn(Account.SObjectType);
        mocks.when(mockAccountsSelector.selectById(new Set<Id> {testAccount.Id})).thenReturn(testAccountList);
        mocks.stopStubbing();
        Application.Selector.setMock(mockAccountsSelector);

        AccountService.updateDescription(mockUow, new Set<Id> {testAccount.Id});
        System.assertEquals('Test', testAccount.Description);
        ((fflib_ISObjectUnitOfWork) mocks.verify(mockUow, 1)).registerDirty((List<Account>) fflib_Match.anyObject());
    }
}
