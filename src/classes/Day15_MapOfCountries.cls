public with sharing class Day15_MapOfCountries {
    
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
        mapOfStateWithCityOfSriLanka.put('Badulla', new List<String> {'Bogoda Wooden Bridge', 'Army Garrison Town', 'Namunukula Mountain Range', 'Indigenous Vedda people, Dambana'});
        mapOfStateWithCityOfSriLanka.put('Colombo', new List<String> {'Mattakkuliya', 'Lunupokuna', 'Mahawatte', 'Modera'});
        mapOfStateWithCityOfSriLanka.put('Kandy', new List<String> {'Poojapitiya', 'Thumpane', 'Udapalatha', 'Ududumbara'});

        Map<String, Map<String, List<String>>> mapOfCountryWithStateOfSriLanka = new Map<String, Map<String, List<String>>>();
        mapOfCountryWithStateOfSriLanka.put('Sri Lanka', mapOfStateWithCityOfSriLanka);


        Map<String, Map<String, Map<String, List<String>>>> mapOfCountries =  new Map<String, Map<String, Map<String, List<String>>>>();
        mapOfCountries.put('IND', mapOfCountryWithStateOfIndia);
        mapOfCountries.put('USA', mapOfCountryWithStateOfUS);
        mapOfCountries.put('LKA', mapOfCountryWithStateOfSriLanka);


        // System.debug('mapOfCountries: ' + mapOfCountries);
        // System.debug('mapOfCountryWithStateOfIndia: ' + mapOfCountryWithStateOfIndia.get('India'));
        // System.debug('mapOfCountryWithStateOfUS: ' + mapOfCountryWithStateOfUS.get('United States of America'));
        // System.debug('mapOfCountryWithStateOfSriLanka: ' + mapOfCountryWithStateOfSriLanka.get('Sri Lanka'));

        // Map<String, Map<String, String>> mapOfResult = new Map<String, Map<String, String>>();

        // for (String countryCode : mapOfCountries.keySet()) {
        //     Map<String, Map<String, List<String>>> mapToStoreValueFromcountryCode = mapOfCountries.get(country);
        //     for (String countryName : mapToStoreValueFromcountryCode.keySet()) {
        //         if (country name starts with s) {
        //             if (!mapOfResult.contains(country name)) {
        //                 mapOfResult.put(country name, Map<String, String>());
        //             }
        //             Map<String, List<String>> 
                    
        //         }
                
        //     }
        // }
    }
}