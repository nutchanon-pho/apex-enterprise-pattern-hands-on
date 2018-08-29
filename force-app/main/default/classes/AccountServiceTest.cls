@isTest
private class AccountServiceTest {
    @isTest static void test_updateDescription() {
        Account testAccount = new Account(Name = 'Hello');
        insert testAccount;
        fflib_ISObjectUnitOfWork uow = Application.UnitOfWork.newInstance();
        AccountService.updateDescription(uow, new Set<Id>{testAccount.Id});
        testAccount = [SELECT Id, Description FROM Account WHERE Id = :testAccount.Id];
        System.assertEquals('Test', testAccount.Description);
    }
}
