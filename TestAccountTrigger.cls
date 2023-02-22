@isTest //Annotation of test class
public class TestAccountTrigger{
 	public static testmethod void testinsert(){
  		Account a = new Account();
  		a.name = 'Test123';
  		insert a;
  	}
   public static testmethod void testupdate(){
		Account a = new Account();
  		a.name = 'Test1234';
  		insert a;
       a.Active__c = true;
       update a;
  }
    public static testmethod void testdelete(){
		Account a = new Account();
  		a.name = 'Test12345';
  		insert a;
       delete a;
  }
}