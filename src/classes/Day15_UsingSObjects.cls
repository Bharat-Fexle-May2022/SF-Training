/*
 * Created Date         :       7/7/2022
 * Author               :       Bharat Kumar
 * Description          :       Insert Data using SObject
*/


public with sharing class Day15_UsingSObjects {
    
    public static void insertDataUsingSObjects() {
        Account acc1 = new Account();
        acc1.Name = 'UPPCL';
        acc1.AccountNumber = '2643';
        insert acc1;
        System.debug('Record 1 Inserted Successfully.');

        Account acc2 = new Account(Name = 'NTPC Limited', AccountNumber = '8798', Phone = '234589249');
        insert acc2;
        System.debug('Record 2 Inserted Successfully.');

        SObject s = new Account();
        s.put('Name', 'Sachin');
        insert s;
        System.debug('Record 3 Inserted Successfully.');
    }
}