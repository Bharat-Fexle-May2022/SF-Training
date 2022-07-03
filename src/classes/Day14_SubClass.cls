public with sharing class Day14_SubClass extends Day14_ImplementSuperKeyword {
    
    public override void printName() {
        super.printName();
        System.debug('But you can call me ' + super.getFirstName());
    }

    public Day14_SubClass(String salutation, String firstName, String lastName) {
        super(salutation, firstName, lastName);
    }

    public Day14_SubClass() {
        super();
    }
    
}