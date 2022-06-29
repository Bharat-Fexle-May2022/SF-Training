public with sharing class LearnVariablesCollectionsandDataTypes {
    public static void DataTypes() {

        //Implementing Data Types

        Boolean isWinner = false;
        System.debug(iswinner);

        System.debug('<---------Assigning Date--------->');
        date myDate1 = date.newInstance(2002, 12, 20);
        Integer day1 = myDate1.day();
        system.assertEquals(20, day1);
        System.debug('Date -> ' + myDate1);
        System.debug('Day -> ' + day1);

        System.debug('<---------Datetime--------->');
        Datetime myDateTime1 = Datetime.newInstance(1960, 2, 17);
        Datetime newDateTime1 = myDateTime1.addDays(2);
        Datetime expected1 = Datetime.newInstance(1960, 2, 19);
        System.assertEquals(expected1, newDateTime1);
        System.debug('Previous Date ->' + myDateTime1);
        System.debug('Modified Date ->' + newDateTime1);

        System.debug('<---------Decimal--------->');
        Decimal firstDecimal = (0.4579060401674421859641886792928).setScale(3);
        System.debug('Value till 3 scale -> ' + firstDecimal);

        System.debug('<---------Double--------->');
        Double d=3.14159;
        System.debug('Value -> ' + d);

        System.debug('<---------ID--------->');
        ID id = '00300000003T2PGAA0';
        System.debug('Id -> ' + id);

        System.debug('<---------Integer--------->');
        Integer i = 1;
        System.debug('Value -> ' + i);
    
        System.debug('<---------Long--------->');
        Long l = 21474836487834593L;
        System.debug('Value -> ' + l);

        System.debug('<---------Object--------->');
        Object obj = 10;
        // Cast the object to an integer.
        Integer i1 = (Integer)obj;
        System.assertEquals(10, i1);
        System.debug('Value stored in object' + i1);

        // Object obj1 = 'abc';
        // //Cast the object to an String
        // String x = (String)obj1;
        // System.assertEquals('abc', x);
        // System.debug(x);

        System.debug('<---------String--------->');
        String s = 'The quick brown fox jumped over the lazy dog.';
        System.debug('Value -> ' + s);

        System.debug('<---------Time--------->');
        Time myTime = Time.newInstance(1, 2, 3, 4);
        Time expected2 = Time.newInstance(4, 2, 3, 4);
        System.debug('Previous Time -> ' + myTime.addHours(5));
        System.debug('Modified Time -> ' + expected2);
    }

    public static void LearnDateMethods() {

        //Implementing Date Methods

        System.debug('<---------addDays--------->');
        Date myDate2 = Date.newInstance(1960, 2, 17);
        Date newDate2 = mydate2.addDays(2);
        System.debug('Previous Date -> ' + myDate2);
        System.debug('Modified Date -> ' + newDate2);

        System.debug('<---------addMonths--------->');
        newDate2 = myDate2.addMonths(3);
        System.debug('Previous Date -> ' + myDate2);
        System.debug('Modified Date -> ' + newDate2);

        System.debug('<---------addYears--------->');
        newDate2 = myDate2.addYears(2);
        System.debug('Previous Date -> ' + myDate2);
        System.debug('Modified Date -> ' + newDate2);

        System.debug('<---------Get Day--------->');
        Integer day2 = myDate2.day();
        System.debug('Days are -> ' + day2);

        System.debug('<---------Calculate Day of Year--------->');
        day2 = myDate2.dayOfYear();
        System.debug('Day of Year -> ' + day2);

        System.debug('<---------Calculate Days between two Dates--------->');
        Date startDate = Date.newInstance(2002, 12, 19);
        Date dueDate = Date.newInstance(2022, 6, 26);
        Integer numberDaysDue = startDate.daysBetween(dueDate);
        System.debug('Difference in Days -> ' + numberDaysDue);

        System.debug('<---------How many days in a specific Month--------->');
        Integer numberDays = date.daysInMonth(2022, 5);
        System.debug('Total Days -> ' + numberDays);

        System.debug('<---------Change format of Date--------->');
        String newFormat = myDate2.format();
        System.debug('yy/mm/dd format -> ' + myDate2);
        System.debug('dd/mm/yy Format -> ' + newFormat);

        System.debug('<---------Check Leap Year--------->');
        Integer year = myDate2.year();
        System.debug(year + ' -> ' + Date.isLeapYear(year));

        System.debug('<---------Check inserted date is current date or not--------->');
        myDate2 = date.today();
        dueDate = date.newInstance(2022, 6, 26);
        boolean dueNow = myDate2.isSameDay(dueDate);
        System.debug(mydate2 + ' -> ' + dueNow);

        System.debug('<---------Get Month--------->');
        myDate2 = date.newInstance(2004, 12, 21);
        Integer month1 = myDate2.month();
        System.debug('Month number is -> ' + month1);

        System.debug('<---------Get Months between two dates--------->');
        Date firstDate = Date.newInstance(2002, 12, 19);
        Date secondDate = Date.newInstance(2022, 6, 26);
        System.debug('First Date -> ' + firstDate);
        System.debug('Second Date -> ' + secondDate);
        System.debug(firstDate.monthsBetween(secondDate) + ' Months');

        System.debug('<---------Assign a Date--------->');
        myDate2 = date.newinstance(1960, 2, 17);
        System.debug('Assigned Date -> ' + myDate2);

        System.debug('<---------Get Current Date--------->');
        System.debug('Current Date -> ' + Date.today());

        System.debug('<---------Get First Date of Month--------->');
        myDate2 = date.newInstance(1987, 12, 17);
        firstDate = myDate2.toStartOfMonth();
        System.debug('First Date of Month -> ' + firstDate);

        System.debug('<---------Get Start of Week--------->');
        myDate2 = Date.newInstance(1992, 5, 12);
        Date weekStart = myDate2.toStartofWeek();
        System.debug('Date of First Day of Week -> ' + weekStart);

        System.debug('<---------Change String in Date--------->');
        String year1 = '2008';
        string month2 = '10';
        string day10 = '5';
        string hour = '12';
        string minute = '20';
        string second = '20';
        string stringDate = year1 + '-' + month2 + '-' + day10 + ' ' + hour + ':' + minute + ':' + second;
        myDate2 = date.valueOf(stringDate);
        System.debug('Date in Date Format -> ' + myDate2);
        System.debug('Date in String Format -> ' + stringDate);

        System.debug('<---------Get Year--------->');
        myDate2 = date.newInstance(1988, 12, 17);
        System.debug(myDate2);
    }

    public static void LearnDateTimeMethods() {
        //Implenting Datetime Methods

        System.debug('<---------Assigning Date Time--------->');
        Datetime myDateTime = Datetime.newInstance(1960, 2, 17);
        Datetime newDateTime = myDateTime.addDays(2);
        System.debug('The Datetime -> ' + newDateTime);

        System.debug('<---------Add hours--------->');
        myDateTime = DateTime.newInstance(1997, 1, 31, 7, 8, 16);
        newDateTime = myDateTime.addHours(3);
        System.debug('Previous Datetime -> ' + myDateTime);
        System.debug('Modified Datetime -> ' + newDateTime);

        System.debug('<---------Add Minutes--------->');
        myDateTime = DateTime.newInstance(1999, 2, 11, 8, 6, 16);
        newDateTime = myDateTime.addMinutes(7);
        System.debug('Previous Datetime -> ' + myDateTime);
        System.debug('Modified Datetime -> ' + newDateTime);

        System.debug('<---------Add Months--------->');
        myDateTime = DateTime.newInstance(2000, 7, 7, 7, 8, 12);
        newDateTime = myDateTime.addMonths(1);
        System.debug('Previous Datetime -> ' + myDateTime);
        System.debug('Modified Datetime -> ' + newDateTime);

        System.debug('<---------Add Seconds--------->');
        myDateTime = DateTime.newInstance(2001, 7, 19, 10, 7, 12);
        newDateTime = myDateTime.addSeconds(4);
        System.debug('Previous Datetime -> ' + myDateTime);
        System.debug('Modified Datetime -> ' + newDateTime);

        System.debug('<---------Add Years--------->');
        myDateTime = DateTime.newInstance(2009, 12, 17, 13, 6, 6);
        newDateTime = myDateTime.addYears(1);
        System.debug('Previous Datetime -> ' + myDateTime);
        System.debug('Modified Datetime -> ' + newDateTime);
    }

    public static void LearnStringMethods() {

        //Implementing String Methods

        System.debug('<---------Make String short--------->');
        String s1 = 'Hello Maximillian';
        String s2 = s1.abbreviate(12);
        System.debug('Abbreviated String -> ' + s2);

        System.debug('<---------Make first character capital--------->');
        s1 = 'i am maximillian';
        System.debug(s1.capitalize());

        System.debug('<---------Get value of a Character--------->');
        s1 = 'Ω is Omega.';
        System.debug(s1.charAt(4));

        System.debug('<---------Compare two Strings--------->');
        s1 = 'abcde';
        s2 = 'abcde';
        if (s1.compareTo(s2) == 0) {
            System.debug(s1 + ' and ' + s2 + ' are equal.');
        } else {
            System.debug(s1 + ' and ' + s2 + ' are not equal.');
        }

        System.debug('<---------Check String contains sub string or not--------->');
        s1 = 'abcde';
        s2 = 'ab';
        if (s1.contains(s2) == true) {
            System.debug('Contains');
        } else {
            System.debug('Not contains');
        }

        System.debug('<---------Check contains whitespace or not--------->');
        s1 = 'Hello Jane';
        System.debug('Contains whitespace -> ' + s1.containsWhitespace()); //true
        s1 = 'HelloJane ';
        System.debug('Contains whitespace -> ' + s1.containsWhitespace()); //true
        s1 = ' HelloJane';
        System.debug('Contains whitespace -> ' + s1.containsWhitespace()); //true
        s1 = 'HelloJane';
        System.debug('Contains whitespace -> ' + s1.containsWhitespace()); //false

        System.debug('<---------Delete whitespace--------->');
        s1 = ' Hello Jane ';
        System.debug('Before deleting whitespace -> ' + s1);
        System.debug(s1.deleteWhitespace());
        System.debug('After deleting whitespace -> ' + s1);

        System.debug('<---------Get index of char from unicode--------->');
        String str2 = '\\u03A9 is Ω (Omega)';
        System.debug('indexOfChar(937)=' + str2.indexOfChar(937));
    }

    public static void PracticeList() {

        // Implementing List

        System.debug('--------Declaration of List--------');
        List<String> myStringList = new List<String>();
        myStringList.add('India');
        myStringList.add('Japan');
        System.debug('List elements -> ' + myStringList);
        
        System.debug('<---------Get List Items--------->');
        List<Integer> myIntegerList = new List<Integer>();
        myIntegerList.add(47);
        myIntegerList.add(97);
        System.debug('List item is -> ' + myIntegerList.get(0));

        System.debug('<---------Add elements at particular index--------->');
        myIntegerList = new Integer[6];
        myIntegerList.add(0, 39);
        myIntegerList.add(4, 52);
        System.debug('List -> ' + myIntegerList);

        System.debug('<---------Push one list into another list--------->');
        List<Integer> myIntegerList2 = new List<Integer>();
        myIntegerList2.add(57);
        myIntegerList2.add(7);
        myIntegerList2.add(23);
        myIntegerList2.add(62);
        myIntegerList = new List<Integer>();
        myIntegerList.add(319);
        System.debug('Before adding list -> ' + myIntegerList);
        myIntegerList.addAll(myIntegerList2);
        System.debug('After adding list -> ' + myIntegerList);
        System.debug('First list - ' + myIntegerList);
        System.debug('Second list - ' + myIntegerList2);

        System.debug('<---------Clear list--------->');
        myIntegerList.clear();
        System.debug('List cleared -> ' + myIntegerList);
    
        System.debug('<---------Get List size--------->');
        myIntegerList.add(78);
        myIntegerList.add(34);
        myIntegerList.add(73);
        myIntegerList.add(38);
        myIntegerList.add(48);
        System.debug(myIntegerList.size());

        System.debug('<---------Sorting of list--------->');
        System.debug('Sorted List -> ' + myIntegerList);

        System.debug('<---------Remove item at particular index--------->');
        myStringList.add('Red');
        myStringList.add('Blue');
        myStringList.add('Green');
        myStringList.remove(2);
        System.debug('Item removed -> ' + myStringList);
    }

    public static void LearnAboutSets() {

        // Implementing Sets

        System.debug('<---------Declaration of Set--------->');
        Set<String> set1 = new Set<String>{'New York', 'Paris'};
        System.debug('Set -> ' + set1);

        System.debug('<---------Add or Remove items to Set--------->');
        Set<Integer> set2 = new Set<Integer>();
        set2.add(1);
        set2.add(3);
        set2.remove(1);
        System.debug('Set -> ' + set2);

        System.debug('<---------Get size of set--------->');
        System.debug('The size of set -> ' + set2.size());
        
        // System.debug('<---------Clear set--------->');
        // System.debug(set2.clear());

        System.debug('<---------Clone Set--------->');
        Set<Integer> cloneOfset2 = new Set<Integer>();
        System.debug('Clone Set -> ' + cloneOfset2);

        System.debug('<---------Check set contains item or not--------->');
        System.debug('Contains -> ' + set2.contains(3));

        System.debug('<---------Check set empty or not--------->');
        System.debug('Empty -> ' + set2.isEmpty());
    }

    public static void LearnAboutMaps() {

        // Implementing Maps

        System.debug('<---------Declaration of Map--------->');
        Map<String, String> country_currencies = new Map<String, String>();
        System.debug('Map -> ' + country_currencies);

        System.debug('<---------Assigning key and value to Map--------->');
        country_currencies = new Map<String, String>{'a' => 'b', 'c' => 'd'.toUpperCase()};
        System.debug('Key and values -> ' + country_currencies);

        System.debug('<---------Get key set--------->');
        Map<Integer, String> m1 = new Map<Integer, String>();
        m1.put(1, 'Aman');
        m1.put(2, 'Suraj');
        // Set<Object> values = m1.values();
        // System.debug('Values are -> ' + values);
        Set<Integer> keys = m1.keySet();
        System.debug('Keys are -> ' + keys);


        System.debug('<---------Get Record--------->');
        Account a = new Account(Name='Acme', BillingCity='New York');

        Map<Integer, Account> map1 = new Map<Integer, Account> {};
        map1.put(1, a);
        System.debug('Record -> ' + map1);

        // When you clone or assign a Map to another map then both the Maps are connected, When you change the field value in one map the connected map field value is automatically updated

        System.debug('<---------Clone Map--------->');
        Map<Integer, Account> map2 = map1.clone();
        Map<Integer, Account> map3 = map1;
        map1.get(1).BillingCity = 'San Francisco';
        System.debug('1' + map1);
        System.debug('2' + map2);
        System.debug('3' + map3);
        map2.get(1).BillingCity = 'New York';
        System.debug('1' + map1);
        System.debug('2' + map2);
        System.debug('3' + map3);        
    }

    public static void LearnAboutVariables() {

        //Declaration
        Integer i1 = 0;
        System.debug('Integer -> ' + i1);

        String str;
        System.debug('String -> ' + str);

        List<String> strList;
        System.debug('List -> ' + strList);

        Set<String> s;
        System.debug('Set -> ' + s);

        Map<ID, String> m;
        System.debug('Map -> ' + m);

        //Declare multiple variables at one time
        Integer i2, j, k;

        //Null variables and Initial values
        System.debug('<---------Default initial values--------->');
        Boolean x = null;
        Decimal d;
        System.debug('Value -> ' + x);
        System.debug('Value -> ' + d);

        Date d1;
        d1.addDays(2);
        System.debug('Date -> ' + d1);

        Integer i;
        {
            // Integer i; This declaration is not allowed
        }

        for(Integer j1 = 0; j1 <= 10; j1++);
        for(Integer k1 = 0; k1 <= 10; k1++);

        //Case Sensitivity
        Integer A;
        //Integer a;

        Account a1;
        ACCOUNT a2;

        Account[] accts = [sELect ID From ACCouNT where nAme = 'fred'];

        String y;
        System.assert('a' == 'A');
        System.assert(y < 'b');
        System.assert(!(y > 'b'));
    }
}