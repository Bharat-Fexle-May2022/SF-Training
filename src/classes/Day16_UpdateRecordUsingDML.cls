/*
 * Created Date         :       8/7/2022
 * Author               :       Bharat Kumar
 * Description          :       Insert, Update, Delete, Retrive, Upsert using DML
*/

public with sharing class Day16_UpdateRecordUsingDML {

    public Day16_UpdateRecordUsingDML() {
        List<Contact> updatedList = new List<Contact>();
        List<Contact> conList = [Select Department , Description from Contact];
        for(Contact con : conList) {
            if (con.Department == 'Finance') {
                con.Description = 'New description';
                updatedList.add(con);
            }
        }

        update updatedList;
        System.debug('Contact Updated Successfully.');
    }

    public static void addAndRetrieveDataUsingDML() {

        Account acc = new Account(Name='Account Example');
        insert acc;
        Account acc1 = [SELECT Name,Industry FROM Account WHERE Name='Account Example' LIMIT 1];

        System.debug('Account Name before update: ' + acc1.Name);
        System.debug('Account Industry before update: ' + acc1.Industry);
        acc1.Name = 'Account of the Day';
        acc1.Industry = 'Technology';
        update acc1;

        Account acc2 = [SELECT Name,Industry FROM Account WHERE Name='Account of the Day' LIMIT 1];

        System.debug('Account Name after update: ' + acc2.Name);
        System.debug('Account Industry after update: ' + acc2.Industry);        
    }

    public static void insertAndUpdateRecords() {
        Account[] accts = new List<Account>();
        for(Integer i=0;i<3;i++) {
            Account a = new Account(Name='July Record ' + i, BillingCity='San Francisco');
            accts.add(a);
        }
        Account accountToUpdate;
        try {
            insert accts;        
            
            accountToUpdate = [SELECT Id, BillingCity FROM Account WHERE Name='July Record 2' AND BillingCity='San Francisco' LIMIT 1];
            System.debug('Before Update -> ' + accountToUpdate);
            accountToUpdate.BillingCity = 'New York';
            update accountToUpdate;
            System.debug('After Update -> ' + accountToUpdate);
        } catch(DmlException e) {
            System.debug('An unexpected error has occurred: ' + e.getMessage());
        }

        Account afterUpdate = [SELECT Id, BillingCity FROM Account WHERE Id=:accountToUpdate.Id];
        System.assertEquals('New York', afterUpdate.BillingCity);
    }

    public static void insertRelatedRecord() {
        try {
            Account acct = new Account(Name='SFDC Account');
            insert acct;
        
            ID acctID = acct.ID;
            Contact con = new Contact(FirstName='Joe', LastName='Smith', Phone='415.555.1212', AccountId=acctID);
            insert con;
            System.debug('Record Inserted Successfully.');
        } catch(DmlException e) {
            System.debug('An unexpected error has occurred: ' + e.getMessage());
        }
    }

    public static void updateRelatedRecord() {
        try {
            Contact queriedContact = [SELECT Account.Name FROM Contact WHERE FirstName = 'Joe' AND LastName='Smith' LIMIT 1];
            queriedContact.Phone = '415.555.1213';
            queriedContact.Account.Industry = 'Technology';
            update queriedContact;
            update queriedContact.Account; 
            System.debug('Record Updated Successfully.');
        } catch(Exception e) {
            System.debug('An unexpected error has occurred: ' + e.getMessage());
        }
    }

    public static void relateRecordUsingExternalId() {
        Opportunity newOpportunity = new Opportunity(Name='OpportunityWithNewAccountInsert', StageName='Prospecting', CloseDate=Date.today().addDays(7));
        Account accountReference = new Account(Id='0015i000007AX0MAAW');
        newOpportunity.Account = accountReference;
        Database.SaveResult results = Database.insert(newOpportunity);
        System.debug('Oppurtunity Created Successfully.');
    }

    public static void upsertingRecords() {
        Account[] acctsList = [SELECT Id, Name, BillingCity FROM Account WHERE BillingCity = 'Bombay'];
        for (Account a : acctsList) {
            a.BillingCity = 'Mumbai';
        }
        Account newAcct = new Account(Name = 'Acme', BillingCity = 'San Francisco');
        acctsList.add(newAcct);
        try {
            upsert acctsList;
            System.debug('Record updated successfully.');
        } catch (DmlException e) {
            System.debug('An unexpected error has occurred: ' + e.getMessage());
        }
    }

    public static void mergingRecords() {
        List<Account> listOfAccounts = new List<Account>{new Account(name='Acme Inc.'), new Account (name='Acme')};                                        
        insert listOfAccounts;

        Account masterAcct = [SELECT Id, Name FROM Account WHERE Name = 'Acme Inc.' LIMIT 1];
        Account mergeAcct = [SELECT Id, Name FROM Account WHERE Name = 'Acme' LIMIT 1];
        Contact c = new Contact(FirstName='Joe',LastName='Merged');
        c.AccountId = mergeAcct.Id;
        insert c;

        try {
            merge masterAcct mergeAcct;
            System.debug('Merge Successful.');
        } catch (DmlException e) {
            System.debug('An unexpected error has occurred: ' + e.getMessage()); 
        }

        masterAcct = [SELECT Id, Name, (SELECT FirstName,LastName From Contacts) FROM Account WHERE Name = 'Acme Inc.' LIMIT 1];

        Account[] result = [SELECT Id, Name FROM Account WHERE Id=:mergeAcct.Id];
        System.assertEquals(0, result.size());
        System.debug('Result -> ' + result);
    }

    public static void deleteRecords() {
        Account[] doomedAccts = [SELECT Id, Name FROM Account WHERE Name = 'DotCom']; 
        try {
            delete doomedAccts;
            System.debug('Record deleted successfully.');
        } catch (DmlException e) {
            System.debug('An unexpected error has occurred: ' + e.getMessage());
        }
    }

    public static void convertLeads() {
        Lead myLead = new Lead(LastName = 'Fry', Company='Fry And Sons');
        insert myLead;

        Database.LeadConvert lc = new database.LeadConvert();
        lc.setLeadId(myLead.id);

        LeadStatus convertStatus = [SELECT Id, MasterLabel FROM LeadStatus WHERE IsConverted=true LIMIT 1];
        lc.setConvertedStatus(convertStatus.MasterLabel);

        Database.LeadConvertResult lcr = Database.convertLead(lc);
        System.debug('Lead converted successfully.');
        System.assert(lcr.isSuccess());
    }
}