public with sharing class EmailManager {
    public EmailManager() {

    }

    public static void sendMail(String address, String subject, String body){
        // Create an email message object
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        
        String[] emails = new String[] {address};
        
        mail.setToAddresses(emails);
        mail.setSubject(subject);
        mail.setPlainTextBody(body);

        Messaging.SendEmailResult[] results = Messaging.sendEmail(new Messaging.SingleEmailMessage[]{ mail });
        inspectResults(results);
    }

    //inspect the sent email status
    private static Boolean inspectResults(Messaging.SendEmailResult[] results) {
        Boolean sendResult = true;

        for(Messaging.SendEmailResult messageStatus : results){
            if(messageStatus.isSuccess()){
                System.debug('Email was Successful');
            }
            else{
                sendResult = false;
                System.debug('The following error occurs when sending message '+messageStatus.getErrors());
            }
        }
        return sendResult;
    }

}