/*──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
* @Description      This is TriggerAccountHelper class.
*                   It has two methods. First is used to send mail of Account Information.
* @author           Bharat Kumar   <bharat.kumar@fexle.com>
* @version          1.0
* @created          2022-07-20
* ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
*/

public with sharing class TriggerAccountHelper {

    /*
    ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
    * Created Date         :       20/7/2022
    * Author               :       Bharat Kumar
    * Description          :       Send mail for Account Information.
    * Returns              :       Void
    * Parameters           :       List of Account
    ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
    */
    
    public static void sendEmailNotification(List<Account> accList){
        List<Messaging.Email> emailList = new List<Messaging.Email>();
        for (Account acc : accList){
            if (acc.Email__c != null){
                Messaging.SingleEmailMessage emailMsg = new Messaging.SingleEmailMessage();
                String[] toAddress = new String[]{acc.Email__c};
                emailMsg.setToAddresses(toAddress);
                String emailSubject = 'Welcome ' + acc.OwnerId;
                emailMsg.setSubject(emailSubject);
                String disName = 'Bharat Kumar';
                emailMsg.setSenderDisplayName(disName);

                String content = 'Hi ' + acc.OwnerId + ',<br/><br/>' +
                'Welcome to Salesforce Ecosystem! <br/><br/>' + 
                'Your Account Number is ' + acc.AccountNumber + '<br/><br/>' + 
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
    * Created Date         :       15/7/2022
    * Author               :       Bharat Kumar
    * Description          :       Generate Account Number.
    * Returns              :       Void
    * Parameters           :       List of Account
    ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
    */

    public static void prefixAccountNumber(List<Account> accList){
        for (Account a : accList){
            if (Trigger.isBefore){
                if (a.AccountNumber == null){
                    Integer randomInt = Integer.valueOf(1000000000 * Math.random());
                    a.AccountNumber = String.valueOf(randomInt);
                }
                if (a.AccountNumber != null){
                    if (a.Type == 'Savings Account'){
                        a.AccountNumber = 'SA' + '-' + a.AccountNumber;    
                    } else if (a.Type == 'Fixed Deposit'){
                        a.AccountNumber = 'FD' + '-' + a.AccountNumber;
                    } else if (a.Type == 'Channel Partner'){
                        a.AccountNumber = 'CP' + '-' + a.AccountNumber;
                    } else if (a.Type == 'Prospect'){
                        a.AccountNumber = 'Pros' + '-' + a.AccountNumber;
                    } else if (a.Type == 'Customer Direct'){
                        a.AccountNumber = 'CD' + '-' + a.AccountNumber;
                    } else if (a.Type == 'Customer Channel'){
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
    }

    public static void testTriggerEvents(List<Account> newList, List<Account> oldList){
        if(Trigger.isBefore){
            System.debug('Checking in Before Trigger Operations.');
            if (Trigger.isInsert){
                System.debug('Check Insert List : Trigger.New ' + newList);
                System.debug('Check Insert List : Trigger.old ' + oldList);
            }
            if (Trigger.isUpdate){
                System.debug('Check Update List : Trigger.New ' + newList);
                System.debug('Check Update List : Trigger.old ' + oldList);

                if (newList[0].Type != oldList[0].Type){
                    System.debug('Type value changed.');
                    System.debug('Trigger.New Data : ' + newList[0].Type);
                System.debug('Trigger.Old Data : ' + oldList[0].Type);
                }
            }
        }

        if (Trigger.isAfter){
            System.debug('Checking in After Trigger Operations.');
        }
    }

}