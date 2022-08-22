/*──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
* Description      This Class is used to validate contact and also sync Contact and Account status.
* author           Bharat Kumar   <bharat.kumar@fexle.com>
* version          1.0
* created          2022-08-16
* ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
*/

public with sharing class ContactTriggerHelper {

    /*
    ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
    * Description          :       It validate the Contact by checking Contact have used unique Pan Card.
    * Author               :       Bharat Kumar
    * Created Date         :       2022-06-15
    * Returns              :       Void
    * Parameters           :       List<Contact__c>
    ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
    */
    static List<ID> setPanCard = new List<ID>();
    public static void ValidateContact(List<Contact> listContact) {
        for (Contact con : listContact) {
            setPanCard.add(con.Pan_Number__c);

        }
        Pan_Card__c listPanCard = [SELECT ID FROM Pan_Card__c WHERE ID = : setPanCard[0] LIMIT 1];
        if (listPanCard != Null) {
            listContact[0].addError('Pan Card already used.');
        }
    }

    /*
    ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
    * Description          :       This method Sync Account and Contact Status.
    * Author               :       Bharat Kumar
    * Created Date         :       2022-08-16
    * Returns              :       Void
    * Parameters           :       List<Contact__c>
    ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
    */

    public static void setContactStatus(List<Contact> conList) {
        
        Set<Id> setOfAccountId = new Set<Id>();
        for (Contact con : conList) {
            setOfAccountId.add(con.AccountId);
        }

        List<Account> accList = [Select Id, Name, Status__c From Account Where Id In : setOfAccountId];
        Map<Id, Account> mapOfAccounts = new Map<Id, Account>();
        mapOfAccounts.putAll(accList);

        for (Contact con : conList) {
            if (String.isBlank(con.Status__c)) {
                Account acc = mapOfAccounts.get(con.AccountId);
                if (!String.isBlank(acc.Status__c)) {
                    con.Status__c = acc.Status__c;
                }
            }
        }
    }
}