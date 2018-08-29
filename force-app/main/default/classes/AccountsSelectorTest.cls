@isTest
private with sharing class AccountsSelectorTest {
    @isTest static void test_selectById() {
        Account testAccount = new Account(Name = 'Test');
        insert testAccount;

        AccountsSelector selector = (AccountsSelector) Application.Selector.newInstance(Account.SObjectType);
        List<Account> accountList = selector.selectById(new Set<Id> {testAccount.Id});
        System.assertEquals(1, accountList.size());
    }
}
