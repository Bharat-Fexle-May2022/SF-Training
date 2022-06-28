public with sharing class PracticeExpressionsandOperators {
    public static void WriteAExpression() {
        Account[] aa = [SELECT Id, Name FROM Account WHERE Name ='Acme'];
        Integer i = [SELECT COUNT() FROM Contact WHERE LastName ='Weissman'];
        List<List<SObject>> searchList = [FIND 'map*' IN ALL FIELDS RETURNING Account (Id, Name), Contact, Opportunity, Lead];
        System.debug(aa);
        System.debug(i);
        System.debug(searchList);
    }

    public static void ExpressionOperatorsInApex() {

        // Assignment Operator
        Integer x = 1, y = 2;
        System.debug(x); //Before assigning the value of y in x
        x = y;
        System.debug(x); //After assigning the value of y in x
        System.debug(y);

        // Addition assignment operator
        Integer x1 = 3, y1 = 5;
        x1 += y1;
        System.debug(x1);

        // Multiplication assignment operator 
        Integer x2 = 3, y2 = 5;
        x2 += y2;
        System.debug(x2);
    }
}