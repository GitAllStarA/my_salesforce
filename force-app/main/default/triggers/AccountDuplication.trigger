trigger AccountDuplication on Account (before insert) {
    for(Account acc:Trigger.new) {
        List<Account> myNew = [select ID, Name from Account where Name= :acc.Name];
        system.debug(myNew);
        if(myNew.size()>0) {
            acc.Name.addError('Account with name already exist');
        } 
    }
}