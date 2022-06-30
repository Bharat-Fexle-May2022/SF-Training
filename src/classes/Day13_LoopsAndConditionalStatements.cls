public with sharing class Day13_LoopsAndConditionalStatements {
    
    public static void implementConditionalStatements() {

        Integer x = 5, sign;
        System.debug('Value of x : ' + x);
        if (x >= 0) {
            if (x == 0) {
                sign = 0;
                System.debug(sign);
            } else  {
                sign = -1;
                System.debug(sign);
            }
        }

        System.debug('<------------------Even or Odd Number------------------>');
        Integer y = x/2;
        System.debug('Number'+y);
        Integer z = y * 2;
        if(x == z ){
            System.debug(x + ' is even.');
        }else{
            System.debug(x + ' is odd.');
        }

        System.debug('<----------Grading System---------->');
        Integer marks = 89;
        if (marks >= 80) {
            System.debug('You got Grade A+');
        } else if (marks >= 60) {
            System.debug('You got Grade A');
        } else if (marks >= 50) {
            System.debug('You got Grade B');
        } else if (marks >= 40) {
            System.debug('You got Grade C');
        } else if (marks >= 33) {
            System.debug('You got Grade D');
        } else {
            System.debug('You are failed.');
        }
    }

    public static void implementLoops() {
        System.debug('<----------Count from 1 to 10 using Do-While loop---------->');
        Integer count = 1;
        do {
            System.debug(count);
            count++;
        } while (count < 11);

        System.debug('<----------Sum of 5 numbers using Do-While loop---------->');
        List<Integer> numList = new List<Integer>{4,9,2,23,74};
        Integer i = 0, s = 0;
        do {
            s = s + numList[i];
            i++;
        } while (i <= 4);
        System.debug('The sum of 5 numbers : ' + s);

        System.debug('<----------Count from 1 to 10 using While loop---------->');
        count = 1;
        while (count < 11) {
            System.debug(count);
            count++;
        }

        System.debug('<----------Sum of 5 numbers using While loop---------->');
        numList = new List<Integer>{78,27,91,23,74};
        i = 0;
        s = 0;
        while (i <= 4) {
            s = s + numList[i];
            i++;
        }
        System.debug('The sum of 5 numbers : ' + s);

        System.debug('<----------Count from 1 to 10 using For loop---------->');
        for (Integer j = 1; j <= 10; j++) {
            System.debug(j);
        }

        System.debug('<----------Sum of 5 numbers using For loop---------->');
        numList = new List<Integer>{43,76,17,49,38};
        s= 0;
        for (Integer j = 0; j <= 4; j++) {
            s = s + numList[j];
        }
        System.debug('The sum of 5 numbers : ' + s);

        System.debug('<----------List or Set iteration For loop---------->');
        Integer[] myInts = new Integer[]{1, 2, 3, 4, 5, 6, 7, 8, 9, 10};

        for (Integer k : myInts) {
            System.debug(k);
        }

        
    }
}