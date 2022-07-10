/*
 * Created Date         :       4/7/2022
 * Author               :       Bharat Kumar
 * Description          :       Map of Country
*/


public with sharing class Day15_MapOfCountries {

    Map<String, Map<String, Map<String, List<String>>>> mapOfCountries =  new Map<String, Map<String, Map<String, List<String>>>>();
    
    public Day15_MapOfCountries() {

        //Map of India
        Map<String, List<String>> mapOfStateWithCityOfIndia = new Map<String, List<String>>();
        mapOfStateWithCityOfIndia.put('Rajasthan', new List<String> {'Jaipur', 'Ajmer', 'Sikar', 'Bharatpur', 'Kota'});
        mapOfStateWithCityOfIndia.put('Uttar Pradesh', new List<String> {'Mathura', 'Kanpur', 'Gorakhpur', 'Hathras', 'Lucknow'});
        mapOfStateWithCityOfIndia.put('Maharashtra', new List<String> {'Ahmednagar', 'Akola', 'Aurangabad', 'Kohlapur', 'Chandrapur'});
        mapOfStateWithCityOfIndia.put('Uttarakhand', new List<String> {'Chamoli', 'Bageshwar', 'Haridwar', 'Pithoragarh', 'Uttarkashi'});

        Map<String, Map<String, List<String>>> mapOfCountryWithStateOfIndia = new Map<String, Map<String, List<String>>>();
        mapOfCountryWithStateOfIndia.put('India', mapOfStateWithCityOfIndia);


        //Map of US
        Map<String, List<String>> mapOfStateWithCityOfUS = new Map<String, List<String>>();
        mapOfStateWithCityOfUS.put('South Dakota', new List<String> {'Grant-Deuel School District', 'Gregory School District', 'Greater Hoyt School District', 'Gettysburg School District'});
        mapOfStateWithCityOfUS.put('Colorado', new List<String> {'Big Sandy School District 100J', 'Creede School District', 'Monte Vista School District C-8', 'Hathras', 'Swink School District 33'});
        mapOfStateWithCityOfUS.put('Alaska', new List<String> {'Anchorage', 'Southeast Fairbanks Census Area', 'Nome Census Area', 'Sitka Borough'});
        mapOfStateWithCityOfUS.put('Florida', new List<String> {'Trinidad School District 1', 'Citrus County Schools', 'Sarasota County Schools', 'Gulf County Schools'});

        Map<String, Map<String, List<String>>> mapOfCountryWithStateOfUS = new Map<String, Map<String, List<String>>>();
        mapOfCountryWithStateOfUS.put('United States of America', mapOfStateWithCityOfUS);


        //Map of Sri Lanka
        Map<String, List<String>> mapOfStateWithCityOfSriLanka = new Map<String, List<String>>();
        mapOfStateWithCityOfSriLanka.put('Anuradha Pura', new List<String> {'Anuradhapura East Electoral District', 'Mihintale Electoral District', 'Kekirawa Electoral District', 'Horowpothana Electoral District'});
        mapOfStateWithCityOfSriLanka.put('Badulla', new List<String> {'Bogoda Wooden Bridge', 'Army Garrison Town', 'Namunukula Mountain Range', 'Indigenous Vedda people'});
        mapOfStateWithCityOfSriLanka.put('Southern Colombo', new List<String> {'Mattakkuliya', 'Lunupokuna', 'Mahawatte', 'Modera'});
        mapOfStateWithCityOfSriLanka.put('Kandy', new List<String> {'Poojapitiya', 'Thumpane', 'Udapalatha', 'Ududumbara'});

        Map<String, Map<String, List<String>>> mapOfCountryWithStateOfSriLanka = new Map<String, Map<String, List<String>>>();
        mapOfCountryWithStateOfSriLanka.put('Sri Lanka', mapOfStateWithCityOfSriLanka);


        mapOfCountries.put('IND', mapOfCountryWithStateOfIndia);
        mapOfCountries.put('USA', mapOfCountryWithStateOfUS);
        mapOfCountries.put('LKA', mapOfCountryWithStateOfSriLanka);

    }


    public void findDistrictUnderSpecificLength() {
        for(String countryCode : mapOfCountries.keySet()) {
            for(String countryName : mapOfCountries.get(countryCode).keySet()) {
                for(String stateName : mapOfCountries.get(countryCode).get(countryName).keySet()) {
                    for(String cityName : mapOfCountries.get(countryCode).get(countryName).get(stateName)) {
                        if(cityName.length()>=10) {
                            System.debug('Districts length greaterthan 10 -> '+ cityName);
                        }
                    }
                }
            }
        }
    }

    Map<String, Map<String, List<String>>> mapCountryStateDistrict = new Map<String, Map<String, List<String>>>();
    List<String> listOfDistricts;
    Map<String, List<String>> mapOfState;

    public void findCountryStateAndDistrictStartsWithS() {
        
        for(String countryCode : mapOfCountries.keySet()) {
            for(String countryName : mapOfCountries.get(countryCode).keySet()) {
                if(countryName.charAt(0) == 83) {
                    mapOfState = new Map<String, List<String>>();
                    for(String stateName : mapOfCountries.get(countryCode).get(countryName).keySet()) {
                        if(stateName.charAt(0) == 83) {
                            listOfDistricts = new List<String>();
                            for(String cityName : mapOfCountries.get(countryCode).get(countryName).get(stateName)) {
                                if(cityName.charAt(0) == 83) {
                                    listOfDistricts.add(cityName);
                                }
                            }
                            mapOfState.put(stateName, listOfDistricts);
                        }
                    }
                    mapCountryStateDistrict.put(countryName, mapOfState);
                }
            }
        }

        System.debug(mapCountryStateDistrict);
    }
}