public class StudentManager {
    public static void createdByRegistrar() {
        Student__c student = new Student__c();
        
        //Personal Information
        student.Date_Of_Birth__c = date.parse('7/9/2001');
        student.Name = 'Ashish Sharma';
        student.Roll_Number__c = 17084;
        student.Father_s_Name__c = 'Mukesh Sharma';
        student.Father_Mobile_Number__c = '9237481534';
        student.Mobile_Number__c = '8462357657';
        student.Email__c = 'ahsish.sharma@gmail.com';
        student.Home_Phone__c = '9237481534';
        student.Overall_Grade__c = 'A';
        student.Address__c = 'BSA College';
        student.City__c = 'Mathura';
        student.Pin_Code__c = 281003;
        student.State__c = 'Uttar Pradesh';
         student.RecordTypeId = [SELECT id FROM RecordType WHERE Name ='Registrar'].Id; //Query for getting Record Type Id of Registrar
        
        //Class Info    
        student.Section__c = 'D';
        student.Class__c = 'B.Tech';
        student.Stream__c = 'Science';
        
        //Fees Details
        student.Current_Year__c = '3rd Year';
        student.Is_Donation__c = False;
        student.Donation_Amount__c = 0;
        student.Fees_Submitted__c = True;
        student.Pending_Fees_Amount__c = 50;
        student.Exam_Fees_Submitted__c = True;
        student.Pending_Exam_Fees__c = 0;
        //student.Pending_Overall_Amount__c = ; //Not Writable (Pending Overall Amount = Pending Fees Amount + Pending Exam Fees)
        
        //Bank Details
        student.Bank_Name__c = 'Central Bank of India';
        student.IFSC_Code__c = 'CBIN0284021';
        student.Account_Number__c = 1463135153;
        student.Bank_Phone_Number__c = '9954199236';
        
        insert student;
    }
    
    public static void createdByTeacher() {
        Student__c student = new Student__c();
        
        //Personal Information
        student.Date_Of_Birth__c = date.parse('5/10/2002');
        student.Name = 'Aditya Sharma';
        student.Roll_Number__c = 17061;
        student.Father_s_Name__c = 'Mukesh Sharma';
        student.Father_Mobile_Number__c = '9184873894';
        student.Mobile_Number__c = '9637491657';
        student.Email__c = 'aditya.sharma@gmail.com';
        student.Home_Phone__c = '9184873834';
        student.Overall_Grade__c = 'B';
        student.Address__c = 'BSA College';
        student.City__c = 'Mathura';
        student.Pin_Code__c = 281003;
        student.State__c = 'Uttar Pradesh';
         student.RecordTypeId = [SELECT id FROM RecordType WHERE Name ='Teacher'].Id; //Query for getting Record Type Id of Teacher
        
        //Class Info    
        student.Section__c = 'B';
        student.Class__c = 'BCA';
        student.Stream__c = 'Commerce';
        
        //Semester Details
        student.X1st_Sem_Back__c = False;
        student.X1st_Sem_Percentage__c = 56;
        student.X2nd_Sem_Back__c = False;
        student.X2nd_Sem_Percentage__c = 60;
        student.X3rd_Sem_Back__c = False;
        student.X3rd_Sem_Percentage__c = 72;
        student.X4th_Sem_Back__c = True;
        student.X4th_Sem_Percentage__c = 69;
        student.Subjects_in_which_Back_1st_Sem__c = '';
        student.Subjects_in_which_Back_2nd_Sem__c = '';
        student.Subjects_in_which_Back_3rd_Sem__c = '';
        student.Subjects_in_which_Back_4th_Sem__c = 'Java Programming, PHP';
        
        //Bank Details
        student.Bank_Name__c = 'Canara Bank';
        student.IFSC_Code__c = 'CNRBOOO3424';
        student.Account_Number__c = 2147134947;
        student.Bank_Phone_Number__c = '8954799236';
        
        insert student;
    }
    
    public static void showStudents() {
        List<Student__c> studentList = [SELECT Student_ID__c, Name, Roll_Number__c, Father_s_Name__c, Email__c, Mobile_Number__c FROM Student__c ORDER BY CreatedDate];
        for(Student__c showstudent : studentList) {
            system.debug('Check Student Data : ' + showstudent);
        }
    }
}