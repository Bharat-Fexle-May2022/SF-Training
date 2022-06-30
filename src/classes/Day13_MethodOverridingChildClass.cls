public with sharing class Day13_MethodOverridingChildClass extends Day13_MethodOverridingParentClass {
    
    public override void display() {
        System.debug('This is child class');
    }

}