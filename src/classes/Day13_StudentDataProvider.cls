public with sharing class Day13_StudentDataProvider {
    public static Student__c stData {
        get {
            if (stData == null) {
                stData = [SELECT Id, Name FROM Student__c where Name != null];
            }
            return stData;
        }

        set {
            stData.Name = stData.Name + Datetime.now();
            System.debug('Check stData.Name ' + stData.Name);
        }
    }

    // public static Student__c stData();
    // public static Student__c stData;

    @AuraEnabled
    public static Student__c getStData(){
        Student__c stLocal;
        if (stLocal == null) {
            stLocal = [SELECT Id, Name FROM Student__c WHERE Name != null];
        }
        return stLocal;
    }
}