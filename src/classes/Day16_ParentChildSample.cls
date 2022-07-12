/*
 * Created Date         :       10/7/2022
 * Author               :       Bharat Kumar
 * Description          :       Create Parent and Child in Single DML Query
*/


public with sharing class Day16_ParentChildSample {
    public static void InsertParentChild() {
        Date dt = Date.today();
        dt = dt.addDays(7);
        Opportunity newOpportunity = new Opportunity(Name='OpportunityWithAccountInsert', StageName='Prospecting', CloseDate=dt);
        
        Account accountReference = new Account(Id = '0015i00000K3RLwAAN');                
        newOpportunity.Account = accountReference;
        
        Account parentAccount = new Account(Name='Hallie', Id = '0015i00000JxkRfAAJ');      
        Database.SaveResult[] results = Database.insert(new SObject[] {parentAccount, newOpportunity });
        for (Integer i = 0; i < results.size(); i++) {
            if (results[i].isSuccess()) {
            System.debug('Successfully created ID: ' + results[i].getId());
            } else {
            System.debug('Error: could not create sobject ' + 'for array element ' + i + '.');
            System.debug('   The error reported was: ' + results[i].getErrors()[0].getMessage() + '\n');
            }
        }
    }
}