public with sharing class AccountService {
    public static void updateDescription(fflib_ISObjectUnitOfWork uow, Set<Id> accountIdSet) {
        service().updateDescription(uow, accountIdSet);
    }

    public static List<Task> createReminder(List<Account> accountList) {
        return service().createReminder(accountList);
    }

    private static IAccountService service() {
        return (IAccountService) Application.Service.newInstance(AccountService.class);
    }
}
