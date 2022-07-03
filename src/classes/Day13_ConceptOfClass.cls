public class Day13_ConceptOfClass {

    Integer classAmount;
    
    public void executeInnerClass() {

        InnerClass ic = new InnerClass();
        ic.multiplyTwoNumbers();

    }

    // Declaration of Inner Class
    public class InnerClass {

        public void multiplyTwoNumbers() {

            System.debug('<--------That is Inner Class code-------->');
            Integer x = 5, y = 2;
            System.debug('Multiplication -> ' + (x*y));

        }

    }

    //Declaration of Class Variables
    protected final String str = 'Hello';
    private Integer i = 56;
    protected Boolean b = true;

    public void implementClassVariables() {

        System.debug('<--------Implementing class variables-------->');
        // str = 'Implementing class variables';
        System.debug('String -> ' + str);
        System.debug('Integer -> ' + i);
        System.debug('Boolean -> ' + b);

    }
    
    public void implementCallByValue() {
        System.debug('<--------Implementing Call By Value-------->');
        String msg = 'Original value';
        System.debug('Before Calling -> ' + msg);
        processString(msg);
        System.debug('After Calling -> ' + msg);
    }
    
    public void processString(String s) {
        s = 'Modified value';
        System.debug('Inside Call By Value Method -> ' + s);
    }


    public void implementCallByReference() {
        System.debug('<--------Implement Call By Reference-------->');
        List<Integer> fillMe = new List<Integer>();
        System.debug('Original List -> ' + fillMe);
        reference(fillMe);
        
        referenceNew(fillMe);
        System.debug('Original List after Calling both methods -> ' + fillMe);
    }
            
    public void reference(List<Integer> m1) {
        m1.add(70);
        m1.add(68);
        m1.add(75);
        m1.add(80);
        m1.add(82);
        System.debug('Original List after calling reference -> ' + m1);
    }    
        
    public void referenceNew(List<Integer> m2) {
        m2.add(55);
        m2.add(59);
        m2.add(62);
        m2.add(60);
        m2.add(63);
        System.debug('Original List after calling referenceNew -> ' + m2);
    }    

}