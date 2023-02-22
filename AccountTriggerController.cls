public with sharing class AccountTriggerController {

    public List<Account> recordNewList = new List<Account>();
    public List<Account> recordOldList = new List<Account>();
    public Map<Id, Account> recordNewMap = new Map<Id, Account>();
    public Map<Id, Account> recordOldMap = new Map<Id, Account>();
    public Boolean isInsert, isUpdate, isDelete, isUndelete = false;
    public static boolean recursionController = false;
    
    public AccountTriggerController(List<Account> newList, List<Account> oldList, Map<Id, Account> newMap, Map<Id, Account> oldMap, boolean isInsert, boolean isUpdate, Boolean isDelete, Boolean isUndelete) {
        this.recordNewList = newList;
        this.recordOldList = oldList;
        this.recordNewMap = newMap;
        this.recordOldMap = oldMap;
        this.isInsert = isInsert;
        this.isUpdate = isUpdate;
        this.isDelete = isDelete;
        this.isUndelete = isUndelete;
    }
    
    public void BeforeInsertEvent(){}
    
    public void BeforeUpdateEvent(){}
    
    public void BeforeDeleteEvent(){}
    
    public void AfterInsertEvent(){
        CreateTeamMember();
    }
    
    public void AfterUpdateEvent(){
        CheckActivate();
    }
    
    public void AfterDeleteEvent(){}
    
    public void AfterUndeleteEvent(){}
    
    public void CheckActivate (){
        
  
        set<id> ACid = new set<Id>();
        for(Account At : recordNewList){
                ACid.add(At.id);
        	}
           List<Account> ACList = new List<Account>([SELECT Id,Active__c, Name from Account where id =: ACid]);
           List<Account> ACList1 = new List<Account>([SELECT Id,Active__c, Name,(SELECT ID,Member_Type__c  From Team_Members__r WHERE Member_Type__c = 'HR' OR Member_Type__c = 'Admin') FROM Account where id =: ACid ]); 
    	    system.debug('ACList1-->'+ACList1);
        	if(ACList1.size()<=0){   
		        for(Account ac : ACList){
	    	     	ac.Active__c = false;
            	    ACList.add(ac);
                    system.debug('tester1');
    	    	}
                if(ACList.size()>0){
                    system.debug('tester1');
                	update ACList;
                }
       		 
        	}
           
    }
    
    public void	CreateTeamMember(){
        
		set<id> ACCid = new set<Id>();
        for(Account Ac : recordNewList){
                ACCid.add(Ac.id);
        	}
        List<Account> ACList = new List<Account>([SELECT Id, Name FROM Account where id =: ACCid]); 
        List<SQX_Team_Members__c> TeamMemberList = new List<SQX_Team_Members__c> ();
        
            for(Account Act : ACList){
                SQX_Team_Members__c Tm =  new SQX_Team_Members__c();
               // for(integer i=1; i<2; i++){
                    Tm.Name = 'Team Member'+1;
                    Tm.Account__c = ACt.id;
                    TeamMemberList.add(Tm);
                
                  SQX_Team_Members__c Tm2 =  new SQX_Team_Members__c();
                	Tm2.Name = 'Team Member'+2;
                    Tm2.Account__c = ACt.id;
                    TeamMemberList.add(Tm2);
                //}    
            }
      		 if(TeamMemberList.size()>=0){
             insert TeamMemberList;
        }      
    } 
}