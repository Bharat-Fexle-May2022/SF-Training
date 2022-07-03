public with sharing class Day14_ImplementKeywordsInApex {

    //We cannot create method with final keyword, Because Classes and Methods are final by default.
    // public static void final read() {}


    public void setValue() {
    final Integer calculateFactorial;
        calculateFactorial = 30; //Value of a final type variable cannot be modified
        System.debug('This is final type variable -> ' + calculateFactorial);
    }

    Boolean firstBool = true;

    // this keyword cannot be used in static method
    // public static void thisKeyword() {
    //     Boolean firstBool = false;
    //     System.debug(this.firstBool);
    //     System.debug(firstBool);
    // }

    public void thisKeyword() {
        Boolean firstBool = false;
        System.debug('This is Class level firstBool value -> ' + this.firstBool);
        System.debug('This is Method level firstBool value -> ' + firstBool);
    }
}