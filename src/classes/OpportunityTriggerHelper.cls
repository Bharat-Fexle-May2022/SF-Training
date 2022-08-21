/*────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
* Created Date          :       30/7/2022
* Author                :       Bharat Kumar
* Description           :       This is OpportunityTriggerHelper class.
*                               It has one method. which is used for perform insert and update operation on Opportunity when stage modified to Shipped to Customer, Return to HQ and Return to Customer.
* ────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
*/

public with sharing class OpportunityTriggerHelper {

    // Constants for Store message for Mail
    Static Final String insertionEmailMessage = ' Inserted Under Installation Account : ';
    Static Final String updateShipmentToInstallationEmailMessage = ' is moved from Shipment to under Installation Account.';
    Static Final String updateInstallationToShipmentEmailMessage = ' is moved from Installation to under Shipment Account.';
    Static Final String notCreatedEmailMessae = ' Record not created.';
    Static Final String notUpdatedEmailMessage = ' Record not updated.';

    /*
    ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
    * Created Date         :       30/7/2022
    * Author               :       Bharat Kumar
    * Description          :       Perform INSERT and UPDATE Operation on Opportunity when stage changes to Shipped to Customer, Return to HQ and Return to Customer.
    * Returns              :       Void
    * Parameters           :       Set<Opportunity>
    ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
    */
    
    public static void insertAndUpdateOpportunity(Set<Opportunity> listOfOpportuinties) {

        // List of SObjects
        List<SObject> createNewAutomobileRecords = new List<SObject>();
        List<SObject> updateExistingAutomobileRecors = new List<SObject>();

        // Old list of Automobile Sensors
        List<Automobile_Sensor__c> existingAutoSensorList = [Select Id, Name, Account__c, Opportunity__c From Automobile_Sensor__c Where Opportunity__c IN : listOfOpportuinties];
        List<Automobile_Presence_Sensor__c> existingAutoPSensorList = [Select Id, Name, Account__c, Opportunity__c From Automobile_Presence_Sensor__c Where Opportunity__c IN : listOfOpportuinties];
        List<Automobile_TDU__c> existingAutoTDUList = [Select Id, Name, Account__c, Opportunity__c From Automobile_TDU__c Where Opportunity__c IN : listOfOpportuinties];
        List<Automobile_Tag__c> existingAutoTagList = [Select Id, Name, Account__c, Opportunity__c From Automobile_Tag__c Where Opportunity__c IN : listOfOpportuinties];

        // Fill the Map of Existing Automobile Records
        Map<String, Automobile_Sensor__c> mapOfExistingAutoSensor = new Map<String, Automobile_Sensor__c>();
        Map<String, Automobile_Presence_Sensor__c> mapOfExistingAutoPSensor = new Map<String, Automobile_Presence_Sensor__c>();
        Map<String, Automobile_TDU__c> mapOfExistingAutoTDUSensor = new Map<String, Automobile_TDU__c>();
        Map<String, Automobile_Tag__c> mapOfExistingAutoTagSensor = new Map<String, Automobile_Tag__c>();

        for (Automobile_Sensor__c autoSensor : existingAutoSensorList) {
            mapOfExistingAutoSensor.put(autoSensor.Name, autoSensor);
        }
        for (Automobile_Presence_Sensor__c autoPSensor : existingAutoPSensorList) {
            mapOfExistingAutoPSensor.put(autoPSensor.Name, autoPSensor);
        }
        for (Automobile_TDU__c autoTDU : existingAutoTDUList) {
            mapOfExistingAutoTDUSensor.put(autoTDU.Name, autoTDU);
        }
        for (Automobile_Tag__c autoTag : existingAutoTagList) {
            mapOfExistingAutoTagSensor.put(autoTag.Name, autoTag);
        }

        // Iterate listOfOpportuinties
        for (Opportunity opp : listOfOpportuinties) {
            List<String> listOfTagDetails = new List<String>();
            List<String> listToCheckDuplicates;
            if (opp.StageName == 'Return to HQ') {
                listToCheckDuplicates = new List<String>();
                if (String.isNotBlank(opp.Shipment_Account__c)) {
                    if (String.isNotBlank(opp.Return_To_HQ__c)) {
                        for (String recordName : opp.Return_To_HQ__c.split('\n')) {
                            listOfTagDetails.add(recordName.trim());                            
                        }
                        for (String recordName : listOfTagDetails) {
                            if (!listToCheckDuplicates.contains(recordName)) {
                                listToCheckDuplicates.add(recordName);
                                if (recordName.startsWith('00:11:CE:00')) {
                                    if (mapOfExistingAutoSensor.containsKey(recordName) && recordName == mapOfExistingAutoSensor.get(recordName).Name && opp.Shipment_Account__c != mapOfExistingAutoSensor.get(recordName).Account__c) {
                                        mapOfExistingAutoSensor.get(recordName).Account__c = opp.Shipment_Account__c;
                                        updateExistingAutomobileRecors.add(mapOfExistingAutoSensor.get(recordName));
                                    }
                                }
                                else if (recordName.startsWith('00:11:CE:D')) {
                                    if (mapOfExistingAutoPSensor.containsKey(recordName) && recordName == mapOfExistingAutoPSensor.get(recordName).Name && opp.Shipment_Account__c != mapOfExistingAutoPSensor.get(recordName).Account__c) {
                                        mapOfExistingAutoPSensor.get(recordName).Account__c = opp.Shipment_Account__c;
                                        updateExistingAutomobileRecors.add(mapOfExistingAutoPSensor.get(recordName));
                                    }
                                }
                                else if (recordName.startsWith('00:11:CE:E')) {
                                    if (mapOfExistingAutoTDUSensor.containsKey(recordName) && recordName == mapOfExistingAutoTDUSensor.get(recordName).Name && opp.Shipment_Account__c != mapOfExistingAutoTDUSensor.get(recordName).Account__c) {
                                        mapOfExistingAutoTDUSensor.get(recordName).Account__c = opp.Shipment_Account__c;
                                        updateExistingAutomobileRecors.add(mapOfExistingAutoTDUSensor.get(recordName));
                                    }
                                }
                                else if (recordName.substring(1,3).isNumeric()) {
                                    if (mapOfExistingAutoTagSensor.containsKey(recordName) && recordName == mapOfExistingAutoTagSensor.get(recordName).Name && opp.Shipment_Account__c != mapOfExistingAutoTagSensor.get(recordName).Account__c) {
                                        mapOfExistingAutoTagSensor.get(recordName).Account__c = opp.Shipment_Account__c;
                                        updateExistingAutomobileRecors.add(mapOfExistingAutoTagSensor.get(recordName));
                                    }
                                }
                            }
                            else {
                                opp.addError('Duplicate not allowed');
                            }
                        }
                    }
                    else {
                        opp.Return_To_HQ__c.addError('Return to HQ Field cannot be empty');
                    }
                }
                else {
                    opp.Shipment_Account__c.addError('Shipment Account is Required for Changing Stage to Return to HQ');
                }
            }
            else if (opp.StageName == 'Return to Customer' || opp.StageName == 'Shipped To Customer') {
                listToCheckDuplicates = new List<String>();
                if (String.isNotBlank(opp.Automobile_Tag_Details_1__c)) {
                    for (String recordName : opp.Automobile_Tag_Details_1__c.split('\n')) {
                        listOfTagDetails.add(recordName.trim());                                            
                    }
                }
                if (String.isNotBlank(opp.Automobile_Tag_Details_2__c)) {
                    for (String recordName : opp.Automobile_Tag_Details_2__c.split('\n')) {
                        listOfTagDetails.add(recordName.trim());                                            
                    }
                }
                if (String.isNotBlank(opp.Automobile_Tag_Details_3__c)) {
                    for (String recordName : opp.Automobile_Tag_Details_3__c.split('\n')) {
                        listOfTagDetails.add(recordName.trim());                                            
                    }
                }
                if (String.isNotBlank(opp.AccountId)) {
                    if (!listOfTagDetails.isEmpty()) {
                        for (String recordName : listOfTagDetails) {
                            if (!listToCheckDuplicates.contains(recordName)) {
                                listToCheckDuplicates.add(recordName);
                                if (recordName.startsWith('00:11:CE:00')) {
                                    if (mapOfExistingAutoSensor.containsKey(recordName) && recordName == mapOfExistingAutoSensor.get(recordName).Name && opp.AccountId != mapOfExistingAutoSensor.get(recordName).Account__c) {
                                        mapOfExistingAutoSensor.get(recordName).Account__c = opp.AccountId;
                                        updateExistingAutomobileRecors.add(mapOfExistingAutoSensor.get(recordName));
                                    }
                                    else if (!mapOfExistingAutoSensor.containsKey(recordName)) {
                                        Automobile_Sensor__c newRecord = new Automobile_Sensor__c();
                                        if (recordName.length() > 18) {
                                            newRecord.Name = recordName.substring(0,18);
                                        }
                                        else {
                                            newRecord.Name = recordName;
                                        }
                                        newRecord.Account__c = opp.AccountId;
                                        newRecord.Opportunity__c = opp.Id;
                                        createNewAutomobileRecords.add(newRecord);
                                    }
                                }
                                else if (recordName.startsWith('00:11:CE:D')) {
                                    if (mapOfExistingAutoPSensor.containsKey(recordName) && recordName == mapOfExistingAutoPSensor.get(recordName).Name && opp.AccountId != mapOfExistingAutoPSensor.get(recordName).Account__c) {
                                        mapOfExistingAutoPSensor.get(recordName).Account__c = opp.AccountId;
                                        updateExistingAutomobileRecors.add(mapOfExistingAutoPSensor.get(recordName));
                                    }
                                    else if (!mapOfExistingAutoPSensor.containsKey(recordName)) {
                                        Automobile_Presence_Sensor__c newRecord = new Automobile_Presence_Sensor__c();
                                        if (recordName.length() > 18) {
                                            newRecord.Name = recordName.substring(0,18);
                                        }
                                        else {
                                            newRecord.Name = recordName;
                                        }
                                        newRecord.Account__c = opp.AccountId;
                                        newRecord.Opportunity__c = opp.Id;
                                        createNewAutomobileRecords.add(newRecord);
                                    }
                                }
                                else if (recordName.startsWith('00:11:CE:E')) {
                                    if (mapOfExistingAutoTDUSensor.containsKey(recordName) && recordName == mapOfExistingAutoTDUSensor.get(recordName).Name && opp.AccountId != mapOfExistingAutoTDUSensor.get(recordName).Account__c) {
                                        mapOfExistingAutoTDUSensor.get(recordName).Account__c = opp.AccountId;
                                        updateExistingAutomobileRecors.add(mapOfExistingAutoTDUSensor.get(recordName));
                                    }
                                    else if (!mapOfExistingAutoTDUSensor.containsKey(recordName)) {
                                        Automobile_TDU__c newRecord = new Automobile_TDU__c();
                                        if (recordName.length() > 18) {
                                            newRecord.Name = recordName.substring(0,18);
                                        }
                                        else {
                                            newRecord.Name = recordName;
                                        }
                                        newRecord.Account__c = opp.AccountId;
                                        newRecord.Opportunity__c = opp.Id;
                                        createNewAutomobileRecords.add(newRecord);
                                    }
                                }
                                else if (recordName.substring(1,3).isNumeric()) {
                                    if (mapOfExistingAutoTagSensor.containsKey(recordName) && recordName == mapOfExistingAutoTagSensor.get(recordName).Name && opp.AccountId != mapOfExistingAutoTagSensor.get(recordName).Account__c) {
                                        mapOfExistingAutoTagSensor.get(recordName).Account__c = opp.AccountId;
                                        updateExistingAutomobileRecors.add(mapOfExistingAutoTagSensor.get(recordName));
                                    }
                                    else if (!mapOfExistingAutoTagSensor.containsKey(recordName)) {
                                        Automobile_Tag__c newRecord = new Automobile_Tag__c();
                                        if (recordName.length() > 18) {
                                            newRecord.Name = recordName.substring(0,18);
                                        }
                                        else {
                                            newRecord.Name = recordName;
                                        }
                                        newRecord.Account__c = opp.AccountId;
                                        newRecord.Opportunity__c = opp.Id;
                                        createNewAutomobileRecords.add(newRecord);
                                    }
                                }
                                else {
                                    opp.addError('Invalid Record : ' + recordName);
                                }
                            }
                            else {
                                opp.addError('Duplicate not allowed' + recordName);
                            }
                        }
                    }
                }
                else {
                    opp.AccountId.addError('Installation Account is Required');
                }
            }
        }

        Set<SObject> setOfAutomobileRecords = new Set<SObject>();
        Boolean insertFlag = false;
        Boolean updateFlag = false;

        if (!createNewAutomobileRecords.isEmpty() && !updateExistingAutomobileRecors.isEmpty()) {
            insertFlag = true;
            updateFlag = true;
            setOfAutomobileRecords.addAll(createNewAutomobileRecords);
            setOfAutomobileRecords.addAll(updateExistingAutomobileRecors);
            sendMail(setOfAutomobileRecords, listOfOpportuinties, insertFlag, updateFlag);
        }
        else if (!createNewAutomobileRecords.isEmpty()) {
            insertFlag = true;
            setOfAutomobileRecords.addAll(createNewAutomobileRecords);
            sendMail(setOfAutomobileRecords, listOfOpportuinties, insertFlag, updateFlag);
        }
        else if (!updateExistingAutomobileRecors.isEmpty()) {
            updateFlag = true;
            setOfAutomobileRecords.addAll(updateExistingAutomobileRecors);
            sendMail(setOfAutomobileRecords, listOfOpportuinties, insertFlag, updateFlag);
        }
    }

    /*
    ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
    * Created Date         :       05/08/2022
    * Author               :       Bharat Kumar
    * Description          :       Send Mail when Opportunity is updated or created
    * Returns              :       Void
    * Parameters           :       List<SObject>, List<SObject>, Set<Opportunity>, Boolean
    ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
    */

    public static void sendMail(Set<SObject> setOfAutomobileRecords, Set<Opportunity> setOfOpportuinties, Boolean insertFlag, Boolean updateFlag) {

        Map<String, SObject> mapOfRecordsWithOpportunity = new Map<String, Opportunity>();
        Map<String, List<SObject>> mapOfAutomobileRecords = new Map<String, List<SObject>>();

        Database.UpsertResult[] results;
        String htmlBody1 = '';
        String htmlBody2 = '';
        String message2Reference;
        List<Messaging.Email> emailList = new List<Messaging.Email>();
        List<SObject> listOfAutomobileRecords = new List<SObject>();
        for (SObject record : setOfAutomobileRecords) {
            listOfAutomobileRecords.add(record);
        }


        System.debug('List of Automobile Records : ' + setOfAutomobileRecords.size());
        results = Database.upsert(listOfAutomobileRecords, false);            

        if (!setOfAutomobileRecords.isEmpty()) {
            for (Opportunity opp : setOfOpportuinties) {
                List<SObject> tempSObj = new List<SObject>();
                for (SObject autoRecord : setOfAutomobileRecords) {
                    if ((String)autoRecord.get('Opportunity__c') == opp.Id) {
                        tempSObj.add(autoRecord);
                    }
                }
                mapOfAutomobileRecords.put(opp.Name, tempSObj);
            }
        }

        for (Opportunity opp : setOfOpportuinties) {
            Messaging.SingleEmailMessage emailMsg = new Messaging.SingleEmailMessage();
            emailMsg.setToAddresses(new String[]{opp.Email__c});
            emailMsg.setSubject(opp.Name + ', Sensor Shipment Successful ' + Datetime.now());
            htmlBody1 = 'Successful <br> <table border="1" style="border-collapse: collapse"><caption>Request Summary Data</caption><tr><th>Automobile Type</th><th>Sensor Name</th><th>Message</th></tr>';
            htmlBody2 = 'Unsuccessful <br> <table border="1" style="border-collapse: collapse"><caption>Request Summary Data</caption><tr><th>Automobile Type</th><th>Sensor Name</th><th>Message</th></tr>';

            if (!mapOfAutomobileRecords.isEmpty()) {
                for (SObject recordName : mapOfAutomobileRecords.get(opp.Name)) {
                    String sensorName = (String)recordName.get('Name');
                    String sensorType;
                    String message1 = '';
                    String message2 = '';
    
                    for (Database.UpsertResult result : results) {
                        if (sensorName.contains('00:11:CE:00')) {
                            sensorType = 'Automobile Sensor';
                            if (result.isCreated()) {
                                message1 = sensorType + insertionEmailMessage + (String)recordName.get('Account__c');
                            }
                            else {
                                message2 = notCreatedEmailMessae;
                            }
                            if (result.isCreated() == false) {
                                if (opp.AccountId == (String)recordName.get('Account__c')) {
                                    message1 = sensorType + updateShipmentToInstallationEmailMessage;
                                }
                                else {
                                    message1 = sensorType + updateInstallationToShipmentEmailMessage;
                                }
                            }
                            else {
                                message2 = notUpdatedEmailMessage;
                            }
                        }
                        else if (sensorName.contains('00:11:CE:D')) {
                            sensorType = 'Automobile Presence Sensor';
                            if (result.isCreated()) {
                                message1 = sensorType + insertionEmailMessage + (String)recordName.get('Account__c');
                            }
                            else {
                                message2 = notCreatedEmailMessae;
                            }
                            if (result.isCreated() == false) {
                                if (opp.AccountId == (String)recordName.get('Account__c')) {
                                    message1 = sensorType + updateShipmentToInstallationEmailMessage;
                                }
                                else {
                                    message1 = sensorType + updateInstallationToShipmentEmailMessage;
                                }
                            }
                            else {
                                message2 = notUpdatedEmailMessage;
                            }
                        }
                        else if (sensorName.contains('00:11:CE:E')) {
                            sensorType = 'Automobile TDU Sensor';
                            if (result.isCreated()) {
                                message1 = sensorType + insertionEmailMessage + (String)recordName.get('Account__c');
                            }
                            else {
                                message2 = notCreatedEmailMessae;
                            }
                            if (result.isCreated() == false) {
                                if (opp.AccountId == (String)recordName.get('Account__c')) {
                                    message1 = sensorType + updateShipmentToInstallationEmailMessage;
                                }
                                else {
                                    message1 = sensorType + updateInstallationToShipmentEmailMessage;
                                }
                            }
                            else {
                                message2 = notUpdatedEmailMessage;
                            }
                        }
                        else if (sensorName.substring(1,3).isNumeric()) {
                            sensorType = 'Automobile Tag';
                            if (result.isCreated()) {
                                message1 = sensorType + insertionEmailMessage + (String)recordName.get('Account__c');
                            }
                            else {
                                message2 = notCreatedEmailMessae;
                            }
                            if (result.isCreated() == false) {
                                if (opp.AccountId == (String)recordName.get('Account__c')) {
                                    message1 = sensorType + updateShipmentToInstallationEmailMessage;
                                }
                                else {
                                    message1 = sensorType + updateInstallationToShipmentEmailMessage;
                                }
                            }
                            else {
                                message2 = notUpdatedEmailMessage;
                            }
                        }
                    }
    
                    // Add message to HTML Body
                    if (String.isNotEmpty(message1)) {
                        htmlBody1 += '<tr><td>' + sensorType + '</td><td>' + sensorName + '</td><td>' + message1 + '</td></tr>';                                            
                    }
                    if (String.isNotEmpty(message2)) {
                        htmlBody2 += '<tr><td>' + sensorType + '</td><td>' + sensorName + '</td><td>' + message2 + '</td></tr>';                       
                        message2Reference = message2;                     
                    }
                }
            }


            // Close HTML Body
            htmlBody1 += '</table><br>';
            htmlBody2 += '</table><br>';
            if (String.isEmpty(message2Reference)) {
                emailMsg.setHtmlBody(htmlBody1 + htmlBody2);                
            }
            else {
                emailMsg.setHtmlBody(htmlBody1);                
            }
            emailList.add(emailMsg);
        }
        Messaging.sendEmail(emailList);
    }   
}