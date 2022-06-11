public class StudentQ {
    public StudentQ() {
        Student__c student = new Student__c();
        
        //Registrar
        
        //Personal Information
        student.Date_Of_Birth__c = date.parse('5/10/2002');
        student.Name = 'Abhay Kevat';
        student.Roll_Number__c = 19026;
        student.Father_s_Name__c = 'Mohan Kevat';
        student.Father_Mobile_Number__c = '9184873834';
        student.Mobile_Number__c = '9638491657';
        student.Email__c = 'abhay.kevat@gmail.com';
        student.Home_Phone__c = '9184873834';
        student.Overall_Grade__c = 'A';
        student.Address__c = 'Vrindavan';
        student.City__c = 'Mathura';
        student.Pin_Code__c = 281003;
        student.State__c = 'Uttar Pradesh';
        string Id = [SELECT id FROM RecordType WHERE Name ='Teacher'].Id;
            
        //Class Info    
        student.Section__c = 'B';
        student.Class__c = 'B.Tech';
        student.Stream__c = 'Science';
            
        //Fees Details
        student.Current_Year__c = '1st Year';
        student.Is_Donation__c = False;
        student.Donation_Amount__c = 0;
        student.Fees_Submitted__c = True;
        student.Pending_Fees_Amount__c = 50;
        student.Exam_Fees_Submitted__c = True;
        student.Pending_Exam_Fees__c = 0;
        //student.Pending_Overall_Amount__c = ; //Not Writable
            
        //Semester Details
        student.X1st_Sem_Back__c = False;
        student.X1st_Sem_Percentage__c = 56;
        student.X2nd_Sem_Back__c = True;
        student.X2nd_Sem_Percentage__c = 60;
        student.X3rd_Sem_Back__c = False;
        student.X3rd_Sem_Percentage__c = 72;
        student.X4th_Sem_Back__c = False;
        student.X4th_Sem_Percentage__c = 69;
        student.Subjects_in_which_Back_1st_Sem__c = '';
        student.Subjects_in_which_Back_2nd_Sem__c = 'C++, DBMS';
        student.Subjects_in_which_Back_3rd_Sem__c = '';
        student.Subjects_in_which_Back_4th_Sem__c = '';
            
        //Bank Details
        student.Bank_Name__c = 'Canara Bank';
        student.IFSC_Code__c = 'CNRBOOO3424';
        student.Account_Number__c = 2147482947;
        student.Bank_Phone_Number__c = '8954199236';
            
        //insert student;
        
        List<Student__c> studentList = [SELECT Student_ID__c, Name, Roll_Number__c, Father_s_Name__c, Email__c, Mobile_Number__c FROM Student__c ORDER BY CreatedById LIMIT 5];
        for(Student__c showstudent : studentList) {
            system.debug('Check Student Data : ' + showstudent);
        }
    }   
}
