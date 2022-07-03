public virtual class Day14_ImplementSuperKeyword {

    public String mySalutation;
    public String myFirstName;
    public String myLastName;

    public Day14_ImplementSuperKeyword() {
        mySalutation = 'Mr.';
        myFirstName = 'Carl';
        myLastName = 'Vonderburg';
        printName();
    }

    public Day14_ImplementSuperKeyword(String salutation, String firstName, String lastName) {
        mySalutation = salutation;
        myFirstName = firstName;
        myLastName = lastName;
        printName();
    }

    public virtual void printName() {
        System.debug('My name is ' + mySalutation + ' ' + myLastName);
    }

    public virtual String getFirstName() {
        return myFirstName;
    }

}