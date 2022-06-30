public with sharing class Day12_BasicsOfApex {
    public Day12_BasicsOfApex(Integer choice) {
        switch on choice {
            when 1 {
                implementExpressions();
            }
            when 2 {
                implementExpressionOperators();
            }
            when 3 {
                implementSafeNavigation();
            }
            when else {
                System.debug('Wrong choice, Try again.');
            }
        }
    }

    public static void implementExpressions() {
        Account[] aa = [SELECT Id, Name FROM Account WHERE Name ='Acme'];
        Integer i = [SELECT COUNT() FROM Contact WHERE LastName ='Weissman'];
        List<List<SObject>> searchList = [FIND 'map*' IN ALL FIELDS RETURNING Account (Id, Name), Contact, Opportunity, Lead];
        System.debug(aa);
        System.debug(i);
        System.debug('The list is ' + searchList);
    }

    public static void implementExpressionOperators() {

        Integer x = 8, y = 3, larger;
        System.debug('Value of x = ' + x);
        System.debug('Value of y = ' + y);
        x += y;
        System.debug('Addition = ' + x);

        x *= y;
        System.debug('Multiplication = ' + x);

        x -= y;
        System.debug('Subtraction = ' + x);

        x /= y;
        System.debug('Subtraction = ' + x);


        //
        Boolean a = true;
        Boolean b = false;
        a |= b;
        System.debug('OR assignment operator = ' + a);

        a &= b;
        System.debug('AND assignment operator = ' + a);

        x <<= y;
        System.debug('Bitwise shift left assignment operator = ' + x);

        x >>= y;
        System.debug('Bitwise shift right assignment operator = ' + x);

        x >>>= y;
        System.debug('Bitwise shift right assignment operator = ' + x);

        System.debug('Ternary Operator');
        larger = x > y ? x : y;
        System.debug('Larger is ' + larger);
        
        a = a && b;
        System.debug('AND logical operator ' + a);

        a = a || b;
        System.debug('OR logical operator ' + a);

        System.debug('x == y -> ' + (x == y));

        List<Integer> l1 = new List<Integer>();
        List<Integer> l2 = new List<Integer>();
        System.debug('l1 === l2 -> ' + (l1 === l2));

        System.debug('x is less than y : ' + (x < y));

        System.debug('x is greater than y : ' + (x > y));

        System.debug('x is less than or equal to y : ' + (x <= y));

        System.debug('x is greater than or equal to y : ' + (x >= y));

        System.debug('x is not equal to y : ' + (x != y));

        System.debug('l1 is not equal to l2 : ' + (l1 !== l2));

        //Increament and Decreament Operator
        x = 2;
        y = 4;
        System.debug('Value of x : ' + x);
        System.debug('Value of y : ' + y);
        System.debug('Post Increament Operator : ' + x++); //2
        System.debug('Pre Increament Operator : ' + ++x); //4
        System.debug('Post Decreament Operator : ' + x--); //4
        System.debug('Pre Decreament Operator : ' + --x); //2
    }

    public static void implementSafeNavigation() {
        Map<Id, Account> accountsMap = new Map<Id, Account>([SELECT Id, Name FROM Account]);

        System.debug(accountsMap.get('0015i000007ASpmAAG')?.Name);
    }

    public void implementOperatorPrecedence() {
        Integer x = 2, y = 4;
        Integer j = ( 87+21-(5*3))/(y++ + --x);
        System.debug(j);
    }
}