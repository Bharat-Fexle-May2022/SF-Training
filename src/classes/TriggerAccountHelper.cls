/*──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
* Created Date          :       20/7/2022
* Author                :       Bharat Kumar
* Description           :       This is TriggerAccountHelper class.
*                               It has two methods. First is used to send mail of Account Information.
* ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
*/

public with sharing class TriggerAccountHelper {

    /*
    ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
    * Created Date         :       20/7/2022
    * Author               :       Bharat Kumar
    * Description          :       Send mail for Account Information.
    * Returns              :       Void
    * Parameters           :       List<Account>
    ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
    */
    
    public static void createAccountEmail(List<Account> accList){
        List<Messaging.Email> emailList = new List<Messaging.Email>();
        for (Account acc : accList){
            if (acc.Email__c != null){
                Messaging.SingleEmailMessage emailMsg = new Messaging.SingleEmailMessage();
                emailMsg.setToAddresses(new String[]{acc.Email__c});
                emailMsg.setSubject('Account Created Successfully');
                emailMsg.setSenderDisplayName('Axis Bank');

                String content = 'Hi ' + acc.Name + ',<br/><br/>' +
                'Welcome to Salesforce Ecosystem! <br/><br/>' + 
                'Your Account Number is ' + acc.AccountNumber + '<br/><br/>' + 
                'Your Account Type is ' + acc.Type + '<br/><br/>' + 
                'Begin your salesforce Admin and Developer Journey with Bharat Kumar <br/><br/>' + 
                'Happy Learning!! <br/><br/>' + 
                'Thank You! <br/><br/>';
                emailMsg.setHtmlBody(content);
                emailList.add(emailMsg);
            }
        }
        Messaging.sendEmail(emailList);
    }

    /*
    ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
    * Created Date         :       27/7/2022
    * Author               :       Bharat Kumar
    * Description          :       This method send a mail ot Account Owner when a account is deleted.
    * Returns              :       Void
    * Parameters           :       List<Account>
    ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
    */

    public static void deleteAccountMail(List<Account> accList){
        List<Messaging.Email> emailList = new List<Messaging.Email>();
        for (Account a : accList) {
            Messaging.SingleEmailMessage deleteAcc = new Messaging.SingleEmailMessage();
            deleteAcc.setToAddresses(new String[]{a.Email__c});
            deleteAcc.setSenderDisplayName('Axis Bank');
            deleteAcc.setSubject('Account Deleted Successfully');
            String body = a.Name + '<br/><br/>' +
            'Your Account Deleted Successfully.';
            deleteAcc.setHtmlBody(body);
            emailList.add(deleteAcc);
        }
        Messaging.sendEmail(emailList);
    }

    /*
    ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
    * Created Date         :       15/7/2022
    * Author               :       Bharat Kumar
    * Description          :       Generate Account Number with Prefix.
    * Returns              :       Void
    * Parameters           :       List<Account>
    ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
    */

    public static void prefixAccountNumber(List<Account> accList){
        for (Account a : accList){
            if (a.AccountNumber == null){
                Integer randomInt = Integer.valueOf(1000000000 * Math.random());
                a.AccountNumber = String.valueOf(randomInt);
            } else {
                a.AccountNumber.addError('You cannot insert account number.');
            }
            if (a.AccountNumber != null){
                if (a.Type == 'Savings Account'){
                    a.AccountNumber = 'SA' + '-' + a.AccountNumber;    
                } else if (a.Type == 'Fixed Deposit'){
                    a.AccountNumber = 'FD' + '-' + a.AccountNumber;
                } else if (a.Type == 'Channel Partner / Reseller'){
                    a.AccountNumber = 'CP' + '-' + a.AccountNumber;
                } else if (a.Type == 'Prospect'){
                    a.AccountNumber = 'Pros' + '-' + a.AccountNumber;
                } else if (a.Type == 'Customer - Direct'){
                    a.AccountNumber = 'CD' + '-' + a.AccountNumber;
                } else if (a.Type == 'Customer - Channel'){
                    a.AccountNumber = 'CC' + '-' + a.AccountNumber;
                } else if (a.Type == 'Installation Partner'){
                    a.AccountNumber = 'IP' + '-' + a.AccountNumber;
                } else if (a.Type == 'Technology partner'){
                    a.AccountNumber = 'TP' + '-' + a.AccountNumber;
                } else if (a.Type == 'Other'){
                    a.AccountNumber = 'Oth' + '-' + a.AccountNumber;
                } else {
                    a.Type.addError('Account Type is required.');
                }
            }
        }    
    }

    /*
    ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
    * Created Date         :       15/7/2022
    * Author               :       Bharat Kumar
    * Description          :       This method show which list is fill or which null for various Trigger events
    * Returns              :       Void
    * Parameters           :       List<Account>, List<Account>
    ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
    */

    public static void testTriggerEvents(List<Account> newList, List<Account> oldList){
        if(Trigger.isBefore){
            System.debug('<-----------------------------Checking in Before Trigger Operations----------------------------->');
            if (Trigger.isInsert){
                System.debug('Check Insert List of Trigger.New -> ' + newList);
                System.debug('Check Insert List of Trigger.old -> ' + oldList);
            }

            if (Trigger.isUpdate){
                System.debug('Check Update List of Trigger.New -> ' + newList);
                System.debug('Check Update List of Trigger.old -> ' + oldList);
            }

            if (Trigger.isDelete) {
                System.debug('Check Delete List of Trigger.New -> ' + newList);
                System.debug('Check Delete List of Trigger.old -> ' + oldList);
            }
        }

        if (Trigger.isAfter){
            System.debug('<-----------------------------Checking in After Trigger Operations----------------------------->');
            if (Trigger.isInsert){
                System.debug('Check Insert List of Trigger.New -> ' + newList);
                System.debug('Check Insert List of Trigger.old -> ' + oldList);
            }

            if (Trigger.isUpdate){
                System.debug('Check Update List of Trigger.New -> ' + newList);
                System.debug('Check Update List of Trigger.old -> ' + oldList);
            }

            if (Trigger.isDelete) {
                System.debug('Check Delete List of Trigger.New -> ' + newList);
                System.debug('Check Delete List of Trigger.old -> ' + oldList);
            }
        }
    }

    /*
    ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
    * Description          :       This method Sync Property and Account Status.
    * Author               :       Bharat Kumar
    * Created Date         :       2022-08-16
    * Returns              :       Void
    * Parameters           :       List<Account__c>
    ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
    */

    public static void setAccountStatus(List<Account> accList) {
        Set<Id> setOfPropertyId = new Set<Id>();
        for (Account acc : accList) {
            setOfPropertyId.add(acc.Property__c);
        }

        List<Property__c> listOfProperties = [Select Id, Name, Status__c From Property__c Where Id In : setOfPropertyId];
        Map<Id, Property__c> mapOfProperties = new Map<Id, Property__c>();
        mapOfProperties.putAll(listOfProperties);

        for (Account acc : accList) {
            System.debug(String.isBlank(acc.Status__c));
            if (String.isBlank(acc.Status__c)) {
                Property__c prop = mapOfProperties.get(acc.Property__c);
                if (!String.isBlank(prop.Status__c)) {
                    acc.Status__c = prop.Status__c;
                }
            }
        }
    }
}