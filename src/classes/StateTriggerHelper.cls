/*──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
* Description      This Class is used to access data from Country, State and District Object.
*                  It updates the JSON data field on Country Object.
*                  It have three methods which are executed on different operations Insert, Update and Delete.
* author           Bharat Kumar   <bharat.kumar@fexle.com>
* version          1.0
* created          2022-08-16
* ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
*/

public with sharing class StateTriggerHelper {

    public static Map<String, Map<String, List<String>>> globalMap = new Map<String, Map<String, List<String>>>();

    /*
    ─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
    * @Description      Wrapper Class for Country.
    * @author           Bharat Kumar   <bharat.kumar@fexle.com>
    * @created          2022-08-16
    * ─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
    */

    public class Country{
        public String countryName{get;set;}
        public String countryCode{get;set;}
        public Integer countryTotalStates{get;set;}
        public Integer countryTotalDistricts{get;set;}
        public List<States> states{get;set;}
    }

    /*
    ─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
    * @Description      Wrapper Class for State.
    * @author           Bharat Kumar   <bharat.kumar@fexle.com>
    * @created          2022-08-16
    * ─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
    */

    public class States{
        public string stateName{get;set;}
        public List<Districts> discricts{get;set;}
    }

    /*
    ─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
    * @Description      Wrapper Class for District.
    * @author           Bharat Kumar   <bharat.kumar@fexle.com>
    * @created          2022-08-16
    * ─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
    */

    public class Districts{
        public string districtName{get;set;}
    }

    /*
    ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
    * Description          :       Updates Country Object when a State is updated.
    * Author               :       Bharat Kumar
    * Created Date         :       2022-08-16
    * Returns              :       Void
    * Parameters           :       List<State__c>, List<State__c>
    ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
    */

    public static void updateCountryAndStateWhenStateIsUpdated(List<State__c> listOfStates, List<State__c> listOfExistingStates) {

        map<Id,Country__c> mapCountryDistrictUpdate=new map<Id,Country__c>();
        List<Id> listOfCountries = new List<Id>();
        List<State__c> listState = [Select Id, Name, Country_Name__c From State__c Where Id In : listOfStates];

        for (State__c st : listOfStates) {
            listOfCountries.add(st.Country_Name__c);
        }

        for (State__c st : listOfExistingStates) {
            listOfCountries.add(st.Country_Name__c);
        }
        
        if (!listOfExistingStates.isEmpty()) {
            for (State__c st : listOfExistingStates) {
                if (!listState.contains(st)) {
                    listState.add(st);                    
                }
            }
        }

        System.debug('listState : ' + listState);
        System.debug('listOfStates : ' + listOfStates);
        System.debug('list of countries : ' + listOfCountries);

        // get aggegrate result on state 
        // Total state and district on country
        AggregateResult[] AggregateResultForCountry = [SELECT COUNT(Id)NumofState, Country_Name__c, SUM(Total_Number_Of_Districts__c)NumofDistricts FROM State__c GROUP BY Country_Name__c];
    
        for (State__c st : listState) {
            for(aggregateResult agr1:AggregateResultForCountry){
                if (st.Country_Name__c == agr1.get('Country_Name__c')) {
                    mapCountryDistrictUpdate.put(String.valueof(agr1.get('Country_Name__c')),new Country__c(Id=String.valueof(agr1.get('Country_Name__c')),Total_Number_Of_Districts__c=Integer.valueof(agr1.get('NumofDistricts')),Total_Number_Of_States__c=Integer.valueof(agr1.get('NumofState'))));                    
                }
            }
        }
    
        if(!mapCountryDistrictUpdate.isEmpty()){
            // updating country record
            update mapCountryDistrictUpdate.Values();
            CountryJSONGenerator(listOfCountries);
        }
    }

    /*
    ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
    * Description          :       Updates Country Object when a District is Inserted.
    * Author               :       Bharat Kumar
    * Created Date         :       2022-08-17
    * Returns              :       Void
    * Parameters           :       List<State__c>
    ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
    */

    public static void updateCountryWhenStateIsInserted(List<State__c> listOfStates) {

        map<Id,Country__c> mapCountryDistrictUpdate=new map<Id,Country__c>();
        List<Id> listOfCountries = new List<Id>();
        List<State__c> listState = [Select Id, Name, Country_Name__c From State__c Where Id In : listOfStates];

        for (State__c st : listOfStates) {
            listOfCountries.add(st.Country_Name__c);
        }

        System.debug('listState : ' + listState);
        System.debug('listOfStates : ' + listOfStates);

        // get aggegrate result on state 
        // Total state and district on country
        AggregateResult[] AggregateResultForCountry = [SELECT COUNT(Id)NumofState, Country_Name__c, SUM(Total_Number_Of_Districts__c)NumofDistricts FROM State__c GROUP BY Country_Name__c];

        for (State__c st : listState) {
            for(aggregateResult agr1:AggregateResultForCountry){
                if (st.Country_Name__c == agr1.get('Country_Name__c')) {
                    mapCountryDistrictUpdate.put(String.valueof(agr1.get('Country_Name__c')),new Country__c(Id=String.valueof(agr1.get('Country_Name__c')),Total_Number_Of_Districts__c=Integer.valueof(agr1.get('NumofDistricts')),Total_Number_Of_States__c=Integer.valueof(agr1.get('NumofState'))));                    
                }
            }
        }

        if(!mapCountryDistrictUpdate.isEmpty()){
            // updating country record
            update mapCountryDistrictUpdate.Values();
            CountryJSONGenerator(listOfCountries);
        }
    }

    /*
    ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
    * Description          :       Updates State and Country Object when a District is Deleted.
    * Author               :       Bharat Kumar
    * Created Date         :       2022-08-17
    * Returns              :       Void
    * Parameters           :       List<State__c>
    ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
    */

    public static void updateCountryWhenStateIsDeleted(List<State__c> listOfStates) {

        map<Id,Country__c> mapCountryDistrictUpdate=new map<Id,Country__c>();
        List<Id> listOfCountries = new List<Id>();
        List<State__c> listState = [Select Id, Name, Country_Name__c From State__c];

        for (State__c st : listOfStates) {
            listOfCountries.add(st.Country_Name__c);
        }
        
        System.debug('listOfCountries : ' + listOfCountries);
        System.debug('listState : ' + listState);
        System.debug('listOfStates : ' + listOfStates);

        // get aggegrate result on state 
        // Total state and district on country
        AggregateResult[] AggregateResultForCountry = [SELECT COUNT(Id)NumofState, Country_Name__c, SUM(Total_Number_Of_Districts__c)NumofDistricts FROM State__c GROUP BY Country_Name__c];

        for (State__c st : listOfStates) {
            for(aggregateResult agr1:AggregateResultForCountry){
                if (st.Country_Name__c == agr1.get('Country_Name__c')) {
                    mapCountryDistrictUpdate.put(String.valueof(agr1.get('Country_Name__c')),new Country__c(Id=String.valueof(agr1.get('Country_Name__c')),Total_Number_Of_Districts__c=Integer.valueof(agr1.get('NumofDistricts')),Total_Number_Of_States__c=Integer.valueof(agr1.get('NumofState'))));                    
                }
            }
        }

        System.debug('mapCountryDistrictUpdate : ' + mapCountryDistrictUpdate);
        if(!mapCountryDistrictUpdate.isEmpty()){
            // updating country record
            update mapCountryDistrictUpdate.Values();
            CountryJSONGenerator(listOfCountries);
        }
    }

    /*
    ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
    * Description          :       Updates JSON data on Country Object
    * Author               :       Bharat Kumar
    * Created Date         :       2022-08-17
    * Returns              :       Void
    * Parameters           :       List<Id>
    ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
    */

    public static void CountryJSONGenerator(List<Id> listOfCountry) {

        // List to hold Country Records
        List<Country__c> listCountryName = [Select Id, Name From Country__c];
        
        // List to hold State Records
        List<State__c> listStateName = [Select Id, Name, Country_Name__c From State__c Order By Name];

        // List to hold District Records
        List<District__c> listDistName = [Select Id, Name, State_Name__c From District__c];
        
        //Fill Global Map
        for (Country__c c : listCountryName) {
            List<String> listTempState = new List<String>();
            Map<String, List<String>> mapTempState = new Map<String, List<String>>();
            for (State__c s : listStateName) {
                if (s.Country_Name__c == c.Id) {
                    listTempState.add(s.Name);
                    List<String> listTempDistrict = new List<String>();
                    for (District__c d : listDistName) {
                        if (d.State_Name__c == s.Id) {
                            listTempDistrict.add(d.Name);
                        }
                    }
                    mapTempState.put(s.Name, listTempDistrict);
                }    
            }
            globalMap.put(c.Name, mapTempState);
        }

        List<Country__c> countryList = [Select Id, Name, Country_Code__c, Total_Number_Of_States__c, Total_Number_Of_Districts__c, Country_JSON_Data__c From Country__c Where Id In : listOfCountry];

        for (Country__c cont : countryList) {
            Country con = new Country();
            List<States> listStates = new List<States>();
            con.countryName = cont.Name;
            for (String s2 : globalMap.get(cont.Name).keySet()){
                States st = new States();
                st.stateName = s2;
                List<Districts> dst = new List<Districts>();

                for(String districtName : globalMap.get(cont.Name).get(s2)){
                    Districts d = new Districts();
                    d.districtName = districtName;
                    dst.add(d);
                }
                st.discricts = dst;
                listStates.add(st);
            }
            con.states = listStates;
            con.countryCode = cont.Country_Code__c;
            con.countryTotalStates = (Integer)cont.Total_Number_Of_States__c;
            con.countryTotalDistricts = (Integer)cont.Total_Number_Of_Districts__c;

            cont.Country_JSON_Data__c = JSON.serialize(con); // Type Casting Total States and Total Districts which are by default Decimal type and Total States and Districts cannot be Decimal.

        }
        // Updating JSON Data
        if (!countryList.isEmpty()) {
            update countryList;            
        }
    }
}