public class Accounts extends fflib_SObjectDomain {
	private fflib_ISObjectUnitOfWork uow;
	private Map<Id, SObject> existingRecords;

	public Accounts(List<Case> records) {
		super(records);
		uow = Application.UnitOfWork.newInstance();
	}

	//public override void onValidate() {
	//	for (Case record : (List<Case>) Records) {
	//	}
	//}

	//public override void onValidate(Map<Id, SObject> existingRecords) {
	//	for (Case record : (List<Case>) Records) {
	//	}
	//}

	public override void onBeforeInsert() {
        stampAccountName();
		createReminder();

		uow.commitWork();
	}

	public override void onBeforeUpdate(Map<Id, SObject> existingRecords) {
		this.existingRecords = existingRecords;


		uow.commitWork();
	}

	public override void onAfterInsert() {

		uow.commitWork();
	}

	public override void onAfterUpdate(Map<Id, SObject> existingRecords) {
		this.existingRecords = existingRecords;


		uow.commitWork();
	}

    public void stampAccountName() {
        for(Account thisAccount : (List<Account>) Records) {
            thisAccount.Name = 'Mr.' + thisAccount.Name;
        }
    }

	public void createReminder() {
		List<Task> taskList = AccountService.createReminder((List<Account>) Records);
		uow.registerNew(taskList);
	}

	public class Constructor implements fflib_SObjectDomain.IConstructable2 {
		public fflib_SObjectDomain construct(List<SObject> sObjectList) {
			return new Accounts(sObjectList);
		}

		public fflib_SObjectDomain construct(List<SObject> sObjectList, SObjectType sObjectType) {
			return new Accounts(sObjectList);
		}
	}
}