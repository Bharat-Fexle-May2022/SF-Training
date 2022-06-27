public with sharing class ContactTriggerHelper {
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
}