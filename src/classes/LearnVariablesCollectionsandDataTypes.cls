public with sharing class LearnVariablesCollectionsandDataTypes {
    public static void DataTypes() {

        //Boolean - It holds only True, False and Null
        Boolean isWinner = false;
        System.debug(iswinner);

        //Date - It indicates a particular day
        date myDate1 = date.newInstance(2002, 12, 20);
        Integer day7 = myDate1.day();
        system.assertEquals(20, day7);
        System.debug(day7);

        //Datetime - It indicates a particular day and time
        Datetime myDateTime1 = Datetime.newInstance(1960, 2, 17);
        Datetime newDateTime1 = myDateTime1.addDays(2);
        Datetime expected1 = Datetime.newInstance(1960, 2, 19);
        System.assertEquals(expected1, newDateTime1);
        System.debug(myDateTime1);
        System.debug(newDateTime1);

        //Decimal - A number that includes a decimal point
        Decimal firstDecimal = (0.4579060401674421859641886792928).setScale(3);
        System.debug(firstDecimal);

        //Double - It stores a float value
        Double d=3.14159;
        System.debug(d);

        //ID - Any valid 18-character Lightning Platform record identifier
        ID id = '00300000003T2PGAA0';
        System.debug(id);

        //Integer - It stores a number that does not include decimal point
        Integer i = 1;
        System.debug(i);
    
        //Long - It's same as Integer, but it stores larger value than Integer
        Long l = 21474836487834593L;
        System.debug(l);

        //Object - It stores any type of data that available in apex

        //First Example of Object
        Object obj = 10;
        // Cast the object to an integer.
        Integer i1 = (Integer)obj;
        System.assertEquals(10, i1);
        System.debug(i1);

        //Second Example of Object
        Object obj1 = 'abc';
        //Cast the object to an String
        String x = (String)obj1;
        System.assertEquals('abc', x);
        System.debug(x);

        //String - Any set of characters surrounded by single quotes
        String s = 'The quick brown fox jumped over the lazy dog.';
        System.debug(s);

        //Time - Adds the specified number of hours to a Time
        Time myTime = Time.newInstance(1, 2, 3, 4);
        Time expected2 = Time.newInstance(4, 2, 3, 4);
        System.assertEquals(expected2, myTime.addHours(3));
        System.debug(myTime.addHours(5));
        System.debug(expected2);
    }

    public static void LearnDateMethods() {
        //addDays(additionalDays) - Adds the specified number of additional days to a Date
        Date myDate2 = Date.newInstance(1960, 2, 17);
        Date newDate1 = mydate2.addDays(2);
        System.debug(myDate2);
        System.debug(newDate1);

        //addMonths(additionalMonths) - Adds the specified number of additional months to a date
        date myDate3 = date.newInstance(1990, 11, 21);
        date newDate2 = myDate3.addMonths(3);
        date expectedDate2 = date.newInstance(1991, 2, 21);
        system.assertEquals(expectedDate2, newDate2);
        System.debug(newDate2);
        System.debug(expectedDate2);

        //addYears(additionalYears) - Adds the specified number of additional years to a Date
        date myDate4 = date.newInstance(1983, 7, 15);
        date newDate3 = myDate4.addYears(2);
        date expectedDate3 = date.newInstance(1985, 7, 15);
        system.assertEquals(expectedDate3, newDate3);
        System.debug(newDate3);
        System.debug(expectedDate3);

        //day() - Returns the day-of-month component of a Date
        date myDate5 = date.newInstance(1989, 4, 21);
        Integer day8 = myDate5.day();
        system.assertEquals(21, day8);
        System.debug(day8);

        //dayOfYear() - Returns the day-of-year component of a Date
        date myDate6 = date.newInstance(2002, 12, 19);
        Integer day9 = myDate6.dayOfYear();
        system.assertEquals(353, day9);
        System.debug(day9);

        //daysBetween(secondDate) - Returns the number of days between the Date that called the method and the specified date
        Date startDate = Date.newInstance(2002, 12, 19);
        Date dueDate = Date.newInstance(2022, 6, 26);
        Integer numberDaysDue = startDate.daysBetween(dueDate);
        System.debug(numberDaysDue);

        // daysInMonth(year, month) - Returns the number of days in the month for the specified year and month (1=Jan)
        Integer numberDays = date.daysInMonth(2022, 5);
        System.debug(numberDays);

        // format() - Returns the Date as a string using the locale of the context user
        // In American-English locale
        date myDate7 = date.newInstance(2001, 3, 21);
        String dayString = myDate7.format();
        system.assertEquals('3/21/2001', dayString);
        System.debug(dayString);

        // isLeapYear(year) - Returns true if the specified year is a leap year
        System.debug(Date.isLeapYear(2024));

        // isSameDay(dateToCompare) - Returns true if the Date that called the method is the same as the specified date
        date myDate8 = date.today();
        date dueDate2 = date.newInstance(2022, 6, 26);
        boolean dueNow = myDate8.isSameDay(dueDate2);
        System.debug(dueNow);

        // month() - Returns the month component of a Date (1=Jan)
        date myDate9 = date.newInstance(2004, 12, 21);
        Integer month1 = myDate9.month();
        System.debug(month1);

        //monthsBetween(secondDate) - Returns the number of months between the Date that called the method and the specified date, ignoring the difference in days
        Date firstDate2 = Date.newInstance(2002, 12, 19);
        Date secondDate = Date.newInstance(2022, 6, 26);
        Integer monthsBetween = firstDate2.monthsBetween(secondDate);
        System.assertEquals(234, monthsBetween);
        System.debug(monthsBetween);

        // newInstance(year, month, day) - Constructs a Date from Integer representations of the year, month (1=Jan), and day
        Date myDate10 = date.newinstance(1960, 2, 17);
        System.debug(myDate10);

        // parse(stringDate) - Constructs a Date from a String. The format of the String depends on the local date format
        date mydate17 = date.parse('12/27/2009');
        System.debug(mydate17);

        // today() - Returns the current date in the current user's time zone
        System.debug(Date.today());

        //toStartOfMonth() - Returns the first of the month for the Date that called the method
        date myDate11 = date.newInstance(1987, 12, 17);
        date firstDate1 = myDate11.toStartOfMonth();
        date expectedDate = date.newInstance(1987, 12, 1);
        system.assertEquals(expectedDate, firstDate1);
        System.debug(firstDate1);

        // toStartOfWeek() - Returns the start of the week for the Date that called the method, depending on the context user's locale
        Date myDate12 = Date.newInstance(1992, 5, 12);
        Date weekStart = myDate12.toStartofWeek();
        System.debug(weekStart);

        // valueOf(stringDate) - Returns a Date that contains the value of the specified String
        string year = '2008';
        string month2 = '10';
        string day10 = '5';
        string hour = '12';
        string minute = '20';
        string second = '20';
        string stringDate = year + '-' + month2 + '-' + day10 + ' ' + hour + ':' + minute + ':' + second;
        Date myDate13 = date.valueOf(stringDate);
        System.debug(myDate13);
        System.debug(stringDate);

        // valueOf(fieldValue) - Converts the specified object to a Date. Use this method to convert a history tracking field value or an object that represents a Date value
        List<AccountHistory> ahlist = [SELECT Field,OldValue,NewValue FROM AccountHistory];
        for(AccountHistory ah : ahlist) {
            System.debug('Field: ' + ah.Field);
            if (ah.field == 'MyDate__c') {
                Date oldValue = Date.valueOf(ah.OldValue);
                Date newValue = Date.valueOf(ah.NewValue);
            }
        }

        //year() - Returns the year component of a Date
        date myDate15 = date.newInstance(1988, 12, 17);
        system.assertEquals(1988, myDate15.year());
        System.debug(myDate15);
    }

    public static void LearnDateTimeMethods() {
        // addDays(additionalDays) - Adds the specified number of days to a Datetime
        Datetime myDateTime2 = Datetime.newInstance(1960, 2, 17);
        Datetime newDateTime2 = myDateTime2.addDays(2);
        Datetime expected3 = Datetime.newInstance(1960, 2, 19);
        System.assertEquals(expected3, newDateTime2);
        System.debug(newDateTime2);

        // addHours(additionalHours) - Adds the specified number of hours to a Datetime
        DateTime myDateTime3 = DateTime.newInstance(1997, 1, 31, 7, 8, 16);
        DateTime newDateTime3 = myDateTime3.addHours(3);
        DateTime expected4 = DateTime.newInstance(1997, 1, 31, 10, 8, 16);
        System.assertEquals(expected4, newDateTime3);
        System.debug(myDateTime3);
        System.debug(newDateTime3);

        // addMinutes(additionalMinutes) - Adds the specified number of minutes to a Datetime
        DateTime myDateTime4 = DateTime.newInstance(1999, 2, 11, 8, 6, 16);
        DateTime newDateTime4 = myDateTime4.addMinutes(7);
        DateTime expected5 = DateTime.newInstance(1999, 2, 11, 8, 13, 16);
        System.assertEquals(expected5, newDateTime4);
        System.debug(myDateTime4);
        System.debug(newDateTime4);

        //addMonths(additionalMonths) - Adds the specified number of months to a Datetime
        DateTime myDateTime5 = DateTime.newInstance(2000, 7, 7, 7, 8, 12);
        DateTime newDateTime5 = myDateTime5.addMonths(1);
        DateTime expected6 = DateTime.newInstance(2000, 8, 7, 7, 8, 12);
        System.assertEquals(expected6, newDateTime5);
        System.debug(myDateTime5);
        System.debug(newDateTime5);

        //addSeconds(additionalSeconds) - Adds the specified number of seconds to a Datetime
        DateTime myDateTime6 = DateTime.newInstance(2001, 7, 19, 10, 7, 12);
        DateTime newDateTime6 = myDateTime6.addSeconds(4);
        DateTime expected7 = DateTime.newInstance(2001, 7, 19, 10, 7, 16);
        System.assertEquals(expected7, newDateTime6);
        System.debug(myDateTime6);
        System.debug(newDateTime6);

        //addYears(additionalYears) - Adds the specified number of years to a Datetime
        DateTime myDateTime7 = DateTime.newInstance(2009, 12, 17, 13, 6, 6);
        DateTime newDateTime7 = myDateTime7.addYears(1);
        DateTime expected8 = DateTime.newInstance(2010, 12, 17, 13, 6, 6);
        System.assertEquals(expected8, newDateTime7);
        System.debug(myDateTime7);
        System.debug(newDateTime7);

        //date() - Returns the Date component of a Datetime in the local time zone of the context user
        DateTime myDateTime8 = DateTime.newInstance(2006, 3, 16, 12, 6, 13);
        Date myDate16 = myDateTime8.date();
        Date expected9 = Date.newInstance(2006, 3, 16);
        System.assertEquals(expected9, myDate16);
        System.debug(myDateTime8);
        System.debug(myDate16);

        //dateGMT() - Return the Date component of a Datetime in the GMT time zone
        // California local time, PST
        DateTime myDateTime9 = DateTime.newInstance(2006, 3, 16, 23, 0, 0);
        Date myDate17 = myDateTime9.dateGMT();
        Date expected10 = Date.newInstance(2006, 3, 17);
        System.assertEquals(expected10, myDate17);
        System.debug(myDateTime9);
        System.debug(myDate17);

        // day() - Returns the day-of-month component of a Datetime in the local time zone of the context user
        DateTime myDateTime10 = DateTime.newInstance(1986, 2, 21, 23, 0, 0);
        System.assertEquals(21, myDateTime10.day());
        System.debug(myDateTime10);

        // dayOfYear() - Returns the day-of-year component of a Datetime in the local time zone of the context user
        Datetime myDate18 = Datetime.newInstance(2008, 2, 6, 8, 30, 12);
        system.assertEquals(myDate18.dayOfYear(), 37);
        System.debug(myDate18.dayOfYear());
    }

    public static void LearnStringMethods() {
        //abbreviate(maxWidth) - It shorts the length of string according specified length
        String s1 = 'Hello Maximillian';
        String s2 = s1.abbreviate(12);
        System.assertEquals('Hello Max...', s2);
        System.assertEquals(12, s2.length());
        System.debug(s2);

        // abbreviate(maxWidth, offset)
        String s3 = 'Hello Maximillian';
        // Start at M
        String s4 = s3.abbreviate(10,5);
        // System.assertEquals('...Max...', s4);
        // System.assertEquals(9, s4.length());
        System.debug(s4);

        //capitalize() - Returns the current String with the first letter changed to title case
        String s5 = 'i am maximillian';
        String s6 = s5.capitalize();
        System.assertEquals('I am maximillian', s6);
        System.debug(s6);

        //center(size)
        String s7 = 'hello';
        String s8 = s7.center(10);
        // System.assertEquals('  hello  ', s8);
        System.debug(s8);

        //charAt(index) - Returns the value of the character at the specified index
        String str = 'Ω is Omega.';
        System.assertEquals(937, str.charAt(0));
        System.debug(str.charAt(4));

        String str9 = 'Ω is Omega.';
        System.debug(str9.codePointAt(1));

        //compareTo(secondString) - Compares two strings lexicographically, based on the Unicode value of each character in the Strings
        String myString1 = 'abcde';
        String myString2 = 'abcde';
        Integer result = myString1.compareTo(myString2);
        System.assertEquals(result, 0);
        System.debug(result);

        //containsNone(inputString) - Returns true if the current String doesn’t contain any of the characters in the specified String; otherwise, returns false
        String s19 = 'abcde';
        System.debug(s19.containsNone('a'));

        //containsWhitespace() - Returns true if the current String contains any white space characters; otherwise, returns false
        String s = 'Hello Jane';
        System.debug(s.containsWhitespace()); //true
        s = 'HelloJane ';
        System.debug(s.containsWhitespace()); //true
        s = ' HelloJane';
        System.debug(s.containsWhitespace()); //true
        s = 'HelloJane';
        System.debug(s.containsWhitespace()); //false

        //deleteWhitespace() - Returns a version of the current String with all white space characters removed
        String s11 = ' Hello Jane ';
        System.debug(s11.deleteWhitespace());

        //indexOfChar(character) - Returns the index of the first occurrence of the character that corresponds to the specified character value
        String str2 = '\\u03A9 is Ω (Omega)';
        // Returns 0, which is the first character.
        System.debug('indexOfChar(937)=' + str2.indexOfChar(937));

        // Output:
        // indexOfChar(937)=0
    }

    public static void PracticeList() {
        // Create an empty list of String
        List<String> my_list = new List<String>();
        // Create a nested list
        List<List<Set<Integer>>> my_list_2 = new List<List<Set<Integer>>>();

        
    }
}