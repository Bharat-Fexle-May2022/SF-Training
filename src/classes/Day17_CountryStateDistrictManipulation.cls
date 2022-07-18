/*
* ─────────────────────────────────────────────────────────────────────────────────────────────────┐
* This Class is used to access data from Country, State and District Object.
* It updates the JSON data field on Country Object.
*
* ──────────────────────────────────────────────────────────────────────────────────────────────────
* @author         Bharat Kumar   <bharat.kumar@fexle.com>
* @modifiedBy     Bharat Kumar   <bharat.kumar@fexle.com>
* @maintainedBy   Bharat Kumar   <bharat.kumar@fexle.com>
* @version        1.0
* @created        2022-07-13
* ──────────────────────────────────────────────────────────────────────────────────────────────────
* @changes
* vX.X            bharat.kumar@fexle.com
* YYYY-MM-DD      Explanation of the change.  Multiple lines can be used to explain the change, but
*                 each line should be indented till left aligned with the previous description text.
* ─────────────────────────────────────────────────────────────────────────────────────────────────┘
*/

public class Day17_CountryStateDistrictManipulation {

    // Global Map
    public Map<String, Map<String, List<String>>> globalMap = new Map<String, Map<String, List<String>>>();

    public Day17_CountryStateDistrictManipulation() {
        // Map to hold Country Id and Name
        Map<String, String> mapOfCountryName = new Map<String,String>();
        List<Country__c> listOfCountryName = [Select Id, Name From Country__c];
        for (Country__c c : listOfCountryName) {
            mapOfCountryName.put(c.Id, c.Name);
        }
        
        // Getting List of State and District Records
        List<State__c> listOfStateName = [Select Id, Name, Country_Name__c From State__c Order By Name];
        List<District__c> listOfDist = [Select Id, Name, State_Name__c From District__c];
        
        //Fill Global Map
        for (Country__c c : listOfCountryName) {
            List<String> listOfTempState = new List<String>();
            Map<String, List<String>> mapOfTempState = new Map<String, List<String>>();
            for (State__c s : listOfStateName) {
                if (s.Country_Name__c == c.Id) {
                    listOfTempState.add(s.Name);
                    List<String> listOfTempDistrict = new List<String>();
                    for (District__c d : listOfDist) {
                        if (d.State_Name__c == s.Id) {
                            listOfTempDistrict.add(d.Name);
                        }
                    }
                    mapOfTempState.put(s.Name, listOfTempDistrict);
                }    
            }
            globalMap.put(c.Name, mapOfTempState);
        }

        updateJSONData();
        updateTotalStatesAndDistricts();
    }

    /**
    * ───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
    * Created Date         :       15/7/2022
    * Author               :       Bharat Kumar
    * Description          :       Updates Total States and Districts on Country and State Object.
    * ───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
    */

    public  void updateTotalStatesAndDistricts(){

        // Map to hold state Record to update
        map<Id,State__c> mapStateDistrictUpdate=new map<Id,State__c>();
        map<Id,Country__c> mapCountryDistrictUpdate=new map<Id,Country__c>();
        
        //Getting aggregrate result on district
        AggregateResult[] districtAggregateResultForState = [SELECT Count(ID)NumofDistrict,State_Name__c FROM District__c GROUP BY State_Name__c];
        
        // Total districts on State
        for(aggregateResult agr:districtAggregateResultForState){
            mapStateDistrictUpdate.put(String.valueof(agr.get('State_Name__c')),new State__c(
                Id=String.valueof(agr.get('State_Name__c')),Total_Number_Of_Districts__c=Integer.valueof(agr.get('NumofDistrict'))));
        }
        if(!mapStateDistrictUpdate.isEmpty()){
            // update state record
            update mapStateDistrictUpdate.Values();
            System.debug('Total District Updation Successful on State');

        }
        
        // get aggegrate result on state 
        // Total state and district on country
        AggregateResult[] AggregateResultForCountry = [SELECT
        COUNT(Id)NumofState,Country_Name__c,SUM(Total_Number_Of_Districts__c)NumofDistricts FROM State__c
        GROUP BY Country_Name__c];

        for(aggregateResult agr1:AggregateResultForCountry){
            mapCountryDistrictUpdate.put(String.valueof(agr1.get('Country_Name__c')),new Country__c(
            Id=String.valueof(agr1.get('Country_Name__c')),Total_Number_Of_Districts__c=Integer.valueof(agr1.get('NumofDistricts')),
            Total_Number_Of_States__c=Integer.valueof(agr1.get('NumofState'))));
        }

        if(!mapCountryDistrictUpdate.isEmpty()){
            // updating country record
            update mapCountryDistrictUpdate.Values();
            System.debug('Total State and District Updation Successful on Country');
        }
    }


    // public List<Country> countryList(get;set;)

    public class Country{
        public string countryName{get;set;}
        public List<States> states{get;set;}
    }

    public class States{
        public string stateName{get;set;}
        public List<Districts> discricts{get;set;}
    }

    public class Districts{
        public string districtName{get;set;}
    }

    /**
    * ───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
    * Created Date         :       15/7/2022
    * Author               :       Bharat Kumar
    * Description          :       Generate JSON of a particular Country.
    * ───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
    */

    public String returnJSON(String countryName2) {
        Country con = new Country();
        List<States> listStates = new List<States>();
        con.countryName = countryName2;
        for (String s2 : globalMap.get(countryName2).keySet()) {
            States st = new States();
            st.stateName = s2;
            List<Districts> dst = new List<Districts>();
            for(String districtName : globalMap.get(countryName2).get(s2)) {
                Districts d = new Districts();
                d.districtName = districtName;
                dst.add(d);
            }
            st.discricts = dst;
            listStates.add(st);
        }
        con.states = listStates;
        return JSON.serialize(con);
    }

    /**
    * ───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
    * Created Date         :       15/7/2022
    * Author               :       Bharat Kumar
    * Description          :       Updates the JSON data field on Country Object.
    * ───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
    */

    public void updateJSONData() {
        List<Country__c> listCountry = [Select Id, Name, Country_JSON_Data__c From Country__c];
        for (Country__c c : listCountry) {
        c.Country_JSON_Data__c = returnJSON(c.Name);
        }
        update listCountry;
        System.debug('JSON Data Updated Successfully.');
    }

    // Maps and List to hold Combination of Country, State and District starts with specific character.
    public Map<String, Map<String, List<String>>> mapCountryWithStartingKey = new Map<String, Map<String, List<String>>>();
    public List<String> listDistrictWithStartingKey;
    public Map<String, List<String>> mapStateWithStartingKey;

    /**
    * ───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
    * Created Date         :       15/7/2022
    * Author               :       Bharat Kumar
    * Description          :       Finds the combination of Country, State and District starts with specific character and put them into Map.
    * ────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
    * @param    searchKey    String
    * ───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
    */

    public void findCombinationWithStartingKey(String searchKey) {
        if (globalMap.size() > 0) {
            for (String c1 : globalMap.keySet()) {
                if (c1.startsWithIgnoreCase(searchKey)) {
                    mapStateWithStartingKey = new Map<String, List<String>>();
                    for (String s1 : globalMap.get(c1).keySet()) {
                        if (s1.startsWithIgnoreCase(searchKey)) {
                            listDistrictWithStartingKey = new List<String>();
                            for (String d1 : globalMap.get(c1).get(s1)) {
                                if (d1.startsWithIgnoreCase(searchKey)) {
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