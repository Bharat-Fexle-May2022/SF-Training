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
}