/*──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
* @Description      This Class is used to access data from Country, State and District Object.
*                   It updates the JSON data field on Country Object.
*                   There is a method which is used to find combination of Countries, States and Districts with a starting keyword.
* @author           Bharat Kumar   <bharat.kumar@fexle.com>
* @version          1.0
* @created          2022-07-11
* ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
*/

public with sharing class CountryStateJSONGenerator {

    // Global Map
    public Map<String, Map<String, List<String>>> globalMap = new Map<String, Map<String, List<String>>>();

    /*
    ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
    * Created Date         :       11/7/2022
    * Author               :       Bharat Kumar
    * Description          :       Constructor is used for fill the Global Map.
    ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
    */

    public CountryStateJSONGenerator() {
        // Map to hold Country Id and Name
        List<Country__c> listCountryName = 
        [Select
            Id
            ,Name
        From Country__c];
        
        // List to hold State Records
        List<State__c> listStateName = 
        [Select Id
            ,Name
            ,Country_Name__c
        From State__c
        Order By Name];

        // List to hold District Records
        List<District__c> listDistName = 
        [Select
            Id
            ,Name
            ,State_Name__c
        From District__c];
        
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

        // Update Total State and District
        updateTotalStatesAndDistricts();
    }
    
    /*
    ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
    * Created Date         :       15/7/2022
    * Author               :       Bharat Kumar
    * Description          :       Updates Total States and Districts on Country and State Object using Aggregate Query.
    * Returns              :       Void
    * Parameters           :       No Parameters
    ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
    */

    public  void updateTotalStatesAndDistricts(){

        // Map to hold state Record to update
        map<Id,State__c> mapStateDistrictUpdate=new map<Id,State__c>();
        map<Id,Country__c> mapCountryDistrictUpdate=new map<Id,Country__c>();
        
        //Getting aggregrate result on district
        AggregateResult[] districtAggregateResultForState = 
        [SELECT
            Count(ID)NumofDistrict
            ,State_Name__c
        FROM District__c
        GROUP BY State_Name__c];
        
        // Total districts on State
        for(aggregateResult agr:districtAggregateResultForState){
            mapStateDistrictUpdate.put(String.valueof(agr.get('State_Name__c')),new State__c(
                Id=String.valueof(agr.get('State_Name__c')),Total_Number_Of_Districts__c=Integer.valueof(agr.get('NumofDistrict'))));
        }

        if(!mapStateDistrictUpdate.isEmpty()){
            // update state record
            update mapStateDistrictUpdate.Values();
        }
        
        // get aggegrate result on state 
        // Total state and district on country
        AggregateResult[] AggregateResultForCountry = 
        [SELECT
            COUNT(Id)NumofState
            ,Country_Name__c
            ,SUM(Total_Number_Of_Districts__c)NumofDistricts
        FROM State__c
        GROUP BY Country_Name__c];

        for(aggregateResult agr1:AggregateResultForCountry){
            mapCountryDistrictUpdate.put(String.valueof(agr1.get('Country_Name__c')),new Country__c(Id=String.valueof(agr1.get('Country_Name__c')),Total_Number_Of_Districts__c=Integer.valueof(agr1.get('NumofDistricts')),Total_Number_Of_States__c=Integer.valueof(agr1.get('NumofState'))));
        }

        if(!mapCountryDistrictUpdate.isEmpty()){
            // updating country record
            update mapCountryDistrictUpdate.Values();
        }
    }



    // public List<Country> countryList(get;set;)

    /*
    ─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
    * @Description      Wrapper Class for Country.
    * @author           Bharat Kumar   <bharat.kumar@fexle.com>
    * @created          2022-07-15
    * ─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
    */

    public class Country{
        public String countryName{get;set;}
        public String countryCode{get;set;}
        public Integer totalStates{get;set;}
        public Integer totalDistricts{get;set;}
        public List<States> states{get;set;}
    }

    /*
    ─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
    * @Description      Wrapper Class for State.
    * @author           Bharat Kumar   <bharat.kumar@fexle.com>
    * @created          2022-07-15
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
    * @created          2022-07-15
    * ─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
    */

    public class Districts{
        public string districtName{get;set;}
    }

    /*
    ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
    * Created Date         :       15/7/2022
    * Author               :       Bharat Kumar
    * Description          :       Generate JSON of a particular Country. It takes four parameters 
    *                              1. Country Name
    *                              2. Country Code
    *                              3. Total States
    *                              4. Total Districts
    * Returns              :       String
    * Parameters           :       String, String, Integer, Integer
    ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
    */

    public String countryJSONGenerator(String countryName2, String countryCode, Integer totalStates, Integer totalDistricts){
        Country con = new Country();
        List<States> listStates = new List<States>();
        con.countryName = countryName2;
        for (String s2 : globalMap.get(countryName2).keySet()){
            States st = new States();
            st.stateName = s2;
            List<Districts> dst = new List<Districts>();
            for(String districtName : globalMap.get(countryName2).get(s2)){
                Districts d = new Districts();
                d.districtName = districtName;
                dst.add(d);
            }
            st.discricts = dst;
            listStates.add(st);
        }
        con.states = listStates;
        con.countryCode = countryCode;
        con.totalStates = totalStates;
        con.totalDistricts = totalDistricts;
        return JSON.serialize(con);
    }

    /*
    ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
    * Created Date         :       15/7/2022
    * Author               :       Bharat Kumar
    * Description          :       Updates JSON data on Country Object. It takes Country Name as Parameter.
    * Returns              :       Void
    * Parameters           :       String
    ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
    */

    public void updateJSONData(String countryName){
        // Variable to hold Country Records
        Country__c country = 
        [Select
            Id
            ,Name
            ,Country_Code__c
            ,Total_Number_Of_States__c
            ,Total_Number_Of_Districts__c
            ,Country_JSON_Data__c
        From Country__c
        Where Name =: countryName
        Limit 1];

        country.Country_JSON_Data__c = countryJSONGenerator(country.Name, country.Country_Code__c, (Integer)country.Total_Number_Of_States__c, (Integer)country.Total_Number_Of_Districts__c); // Type Casting Total States and Total Districts which are by default Decimal type and Total States and Districts cannot be Decimal.
        // Updating JSON Data
        update country;
        System.debug('Updatioin Successful.');
    }

    /*
    ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
    * Created Date         :       15/7/2022
    * Author               :       Bharat Kumar
    * Description          :       Finds the combination of Country, State and District starts with specific character which is 
    *                              passed to it and put them into Map.
    * Returns              :       Void
    * Parameters           :       String
    ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
    */

    // Maps and List to hold Combination of Country, State and District starts with specific character.
    public Map<String, Map<String, List<String>>> mapCountryWithStartingKey = new Map<String, Map<String, List<String>>>();
    public List<String> listDistrictWithStartingKey;
    public Map<String, List<String>> mapStateWithStartingKey;


    public void findCombinationWithStartingKey(String searchKey){
        if (globalMap.size() > 0){
            for (String c1 : globalMap.keySet()){
                if (c1.startsWithIgnoreCase(searchKey)){
                    mapStateWithStartingKey = new Map<String, List<String>>();
                    for (String s1 : globalMap.get(c1).keySet()){
                        if (s1.startsWithIgnoreCase(searchKey)){
                            listDistrictWithStartingKey = new List<String>();
                            for (String d1 : globalMap.get(c1).get(s1)){
                                if (d1.startsWithIgnoreCase(searchKey)){
                                    listDistrictWithStartingKey.add(d1);                                
                                }
                            }
                            mapStateWithStartingKey.put(s1, listDistrictWithStartingKey);
                        }
                    }
                    mapCountryWithStartingKey.put(c1, mapStateWithStartingKey);
                }
            }
            System.debug('Map of Country, State and District starts with ' + ' -> ' + mapCountryWithStartingKey);
        } else {
            System.debug('Map is empty.');
        }        
    }
}