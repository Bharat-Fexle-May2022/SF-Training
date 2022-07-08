public with sharing class Day15_PracticeMapOfCountry {

    Map<String,Map<String,Map<String,List<String>>>> mapOfCountries = new Map<String,Map<String,Map<String,List<String>>>>();

    public Day15_PracticeMapOfCountry() {

        // Map of Japan
        Map<String, List<String>> mapOfStateWithCityOfJapan = new Map<String,List<String>>();
        mapOfStateWithCityOfJapan.put('Akita', new List<String>{'Kohoku', 'Shogunno', 'Tsuchizaki', 'Sotoasahikawa', 'Terauchi'});
        mapOfStateWithCityOfJapan.put('Kyoto', new List<String>{'Central Kyoto', 'Nishijin', 'Northern Higashiyama', 'Southern Higashiyama', 'Kohoku'});
        mapOfStateWithCityOfJapan.put('Saitama', new List<String>{'Yoshikawa', 'Toda', 'Sayama', 'Sōka', 'Kawaguchi'});
        mapOfStateWithCityOfJapan.put('Saga', new List<String>{'Kanzaki District', 'Higashimatsuura District', 'Fujitsu District', 'Miyaki District', 'Nishimatsuura District'});

        Map<String,Map<String,List<String>>> mapOfCountryWithStateOfJapan = new Map<String,Map<String,List<String>>>();
        mapOfCountryWithStateOfJapan.put('Japan', mapOfStateWithCityOfJapan);

        // Map of South Korea
        Map<String,List<String>> mapOfStateWithCityOfSouthKorea = new Map<String,List<String>>();
        mapOfStateWithCityOfSouthKorea.put('Daejeon', new List<String>{'Daedeok-gu', 'Yuseong-gu', 'Jung-gu', 'Dong-gu', 'Seo-gu'});
        mapOfStateWithCityOfSouthKorea.put('Busan', new List<String>{'Dong-gu', 'Jung-gu', 'Busanjin-gu', 'Suyeong-gu', 'Buk-gu'});
        mapOfStateWithCityOfSouthKorea.put('Daegu', new List<String>{'Seo-gu', 'Buk-gu', 'Dalseo-gu', 'Nam-gu', 'Suseong-gu'});
        mapOfStateWithCityOfSouthKorea.put('Seoul', new List<String>{'Guro-gu', 'Jongno-gu', 'Mapo-gu', 'Nowon-gu', 'Songpa-gu'});

        Map<String,Map<String,List<String>>> mapOfCountryWithStateOfSouthKorea = new Map<String,Map<String,List<String>>>();
        mapOfCountryWithStateOfSouthKorea.put('South Korea', mapOfStateWithCityOfSouthKorea);

        // Map of Switzerland
        Map<String,List<String>> mapOfStateWithCityOfSwitzerland = new Map<String,List<String>>();
        mapOfStateWithCityOfSwitzerland.put('Zurich', new List<String>{'At the Foot of the Uetliberg', 'Right of the Limmat', 'Schwamendingen', 'Left Shore of the Lake', 'Old Town, City Center'});
        mapOfStateWithCityOfSwitzerland.put('Uri', new List<String>{});
        mapOfStateWithCityOfSwitzerland.put('Vaud', new List<String>{'Cossonay', 'Aubonne', 'Orbe', 'Lavaux', 'Moudon'});
        mapOfStateWithCityOfSwitzerland.put('Solothurn', new List<String>{'Wasseramt-Bucheggberg', 'Thal-Gäu', 'Solothurn-Lebern', 'Olten-Gösgen', 'Dorneck-Thierstein'});

        Map<String,Map<String,List<String>>> mapOfCountryWithStateOfSwitzerland = new Map<String,Map<String,List<String>>>();
        mapOfCountryWithStateOfSwitzerland.put('Switzerland', mapOfStateWithCityOfSwitzerland);

        mapOfCountries.put('JPN', mapOfCountryWithStateOfJapan);
        mapOfCountries.put('KOR', mapOfCountryWithStateOfSouthKorea);
        mapOfCountries.put('CHE', mapOfCountryWithStateOfSwitzerland);
    }

    public void findDistrictGreaterThanSpecificLength(Integer lengthOfDistrict) {
        if(lengthOfDistrict >= 1) {
            for(String countryCode : mapOfCountries.keySet()) {
                for(String countryName : mapOfCountries.get(countryCode).keySet()) {
                    for(String stateName : mapOfCountries.get(countryCode).get(countryName).keySet()) {
                        for(String districtName : mapOfCountries.get(countryCode).get(countryName).get(stateName))
                        if (districtName.length() >= lengthOfDistrict) {
                            System.debug('Districts with length greater than ' + lengthOfDistrict + ' : ' + districtName);
                        }
                    }
                }
            }
        } else {
            System.debug('Length must be greater than 0.');            
        }
    }

    public void findCountryStateAndDistrictStartsWithSpecificCharacter(String chr) {
        Map<String, Map<String, List<String>>> mapOfCountryStateDistricts = new Map<String, Map<String, List<String>>>();
        Map<String, List<String>> mapOfState;
        List<String> listOfDistricts;

        if (chr.length() == 1) {
            for (String countryCode : mapOfCountries.keySet()) {
                for (String countryName : mapOfCountries.get(countryCode).keySet()) {
                    if(countryName.startsWithIgnoreCase(chr)) {
                        mapOfState = new Map<String, List<String>>();
                        for(String stateName : mapOfCountries.get(countryCode).get(countryName).keySet()) {
                            if(stateName.startsWithIgnoreCase(chr)) {
                                listOfDistricts = new List<String>();
                                for(String districtName : mapOfCountries.get(countryCode).get(countryName).get(stateName)) {
                                    if (districtName.startsWithIgnoreCase(chr)) {
                                        listOfDistricts.add(districtName);
                                    }
                                }
                                mapOfState.put(stateName, listOfDistricts);
                            }
                        }
                        mapOfCountryStateDistricts.put(countryName, mapOfState);
                    }
                }
            }
        } else {
            System.debug('Only one character is allowed.');          
        }
        System.debug(mapOfCountryStateDistricts);
    }

}