/*
 * Created Date         :       7/7/2022
 * Author               :       Bharat Kumar
 * Description          :       Type Casting
*/


public with sharing class Day15_ConvertToCLA {

    List<Contact> contacts = new List<Contact>();
    List<Lead> leads = new List<Lead>();
    List<Account> accounts = new List<Account>();
    
    public void convertType(String phoneNumber) {

        List<List<SObject>> results = [FIND :phoneNumber 
            IN Phone FIELDS 
            RETURNING Contact(Id, Phone, FirstName, LastName), 
            Lead(Id, Phone, FirstName, LastName),
            Account(Id, Phone, Name)];
        List<SObject> records = new List<SObject>();
        records.addAll(results[0]); //add Contact results to our results super-set
        records.addAll(results[1]); //add Lead results
        records.addAll(results[2]); //add Account results
 
        if (!records.isEmpty()) { 
            for (Integer i = 0; i < records.size(); i++) { 
                SObject record = records[i];
                if (record.getSObjectType() == Contact.sObjectType) { 
                    contacts.add((Contact) record);
                } else if (record.getSObjectType() == Lead.sObjectType){ 
                    leads.add((Lead) record);
                } else if (record.getSObjectType() == Account.sObjectType) { 
                    accounts.add((Account) record);
                }
            }
        }
        showList();
    }

    // public static void showList() {
    //     System.debug(Day15_ConvertToCLA.contacts);
    //     System.debug(Day15_ConvertToCLA.leads);
    //     System.debug(Day15_ConvertToCLA.accounts);
    // }

    public void showList() {
        System.debug(contacts);
        System.debug(leads);
        System.debug(accounts);
    }

    public static void typeCastingExample() {
        Account a = new Account(Name = 'Gopal1', BillingCity = 'San Francisco');
        insert a;
        sObject s = [SELECT Id, Name FROM Account WHERE Name = 'Acme' LIMIT 1];
        ID id = s.ID;
        Account convertedAccount = (Account)s;
        convertedAccount.name = 'Gopal2';
        update convertedAccount;
        Contact con = new Contact(FirstName = 'Sal', Account = convertedAccount);
    }
}