public with sharing class Day14_InstanceOfExample {
    sObject s = new Contact();

// Account a = (Account)s;

Contact c = (Contact)s;


public Day14_InstanceOfExample() {

    // Account o = null;
    // Boolean result = o instanceof Account;
    // System.debug(result);

    if(s instanceof Account) {
        Account a = (Account)s;
        System.debug('This is Account type');
    } else if(s instanceof Contact) {
        Contact c = (Contact)s;
        System.debug('This is Contact type');
    }
}

}