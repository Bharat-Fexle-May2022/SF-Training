public with sharing class Day13_ProcessStudentData {
    public Day13_ProcessStudentData() {
        Student__c st = Day13_StudentDataProvider.stData;
    }

    public void saveStudentData() {
        Student__c s1;
        Student__c studentData = s1;
        Day13_StudentDataProvider.stData = s1;
    }
}