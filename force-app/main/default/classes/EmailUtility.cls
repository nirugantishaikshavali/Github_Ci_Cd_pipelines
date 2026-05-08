public class EmailUtility {
    
    public static void sendEmail(){
        
        Messaging.SingleEmailMessage email=new Messaging.SingleEmailMessage();
        
        email.setSubject('My First Email from Salesforce');
        
        List<String>toAddress=new List<String>();
        toAddress.add('nirugantishaikshavali78@gmail.com');
        
        List<String>bccAddress=new List<String>();
        bccAddress.add('nirugantishaikshavali78@gmail.com');
        
        email.setPlainTextBody('Hello Dear,My First Email From Salesforce');
        email.setToAddresses(toAddress);
        email.setBccAddresses(bccAddress);
        
        List<Messaging.SingleEmailMessage>emailMessages=new List<Messaging.SingleEmailMessage>();
        emailMessages.add(email);
        List<Messaging.SendEmailResult>sendEmailResults=Messaging.sendEmail(emailMessages,false);
        for(Messaging.SendEmailResult sr:sendEmailResults){
            Boolean isSuccess=sr.isSuccess();
            if(isSuccess){
                System.debug('Email Sent Successfully');
            }else{
                System.debug('Error while sending Email');
                List<Messaging.SendEmailError> errors=sr.getErrors();
                System.debug(errors);
            }
        }
        
    }

}