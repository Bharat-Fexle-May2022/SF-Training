public with sharing class Day13_MethodOverloadingAndConstructors {

    private static final Integer defaultSize = 10;

    Integer size;

    public Day13_MethodOverloadingAndConstructors() {
        System.debug('Default Constructor');
        System.debug(defaultSize);
    }

    public Day13_MethodOverloadingAndConstructors(Integer ObjectSize) {
        System.debug('Parameterized Constructor');
        size = ObjectSize;
        System.debug(size);
    }
}