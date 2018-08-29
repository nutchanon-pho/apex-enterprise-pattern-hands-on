public with sharing class AccountServiceImpl implements IAccountService {
    public void updateDescription(fflib_ISObjectUnitOfWork uow, Set<Id> accountIdSet) {
        AccountsSelector selector = (AccountsSelector) Application.Selector.newInstance(Account.SObjectType);
        List<Account> accountList = selector.selectById(accountIdSet);
        for(Account thisAccount : accountList) {
            thisAccount.Description = 'Test';
        }
        uow.registerDirty(accountList);
        uow.commitWork();
    }

    public List<Task> createReminder(List<Account> accountList) {
        List<Task> taskList = new List<Task>();
        for(Account thisAccount : accountList) {
            taskList.add(new Task(Subject = 'Reminder', WhatId = thisAccount.Id));
        }
        return taskList;
    }
}
