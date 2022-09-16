public with sharing class ContactController {
    @AuraEnabled
    public static string getTextMethod1(){
        return 'Method-1';
    }
 
    @AuraEnabled
    public static string getTextMethod2(){
        return 'Method-2';
    }
 
    @AuraEnabled
    public static string getTextMethod3(){
        return 'Method-3';
    }

    @AuraEnabled
    public static List<Contact> getContactTile() {
        List<Contact> conList = [Select Id, Name, Title, Phone, Email From Contact Order By CreatedDate Asc Limit 17]; 
        return conList;
    }
}