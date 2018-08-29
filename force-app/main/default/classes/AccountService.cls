public with sharing class AccountService {
    public static void updateDescription(fflib_ISObjectUnitOfWork uow, Set<Id> accountIdSet) {
        service().updateDescription(uow, accountIdSet);
    }

    private static IAccountService service() {
        return (IAccountService) Application.Service.newInstance(AccountService.class);
    }
}
