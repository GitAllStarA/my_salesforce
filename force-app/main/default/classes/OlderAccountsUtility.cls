public class OlderAccountsUtility {
    
    public static void updateOlderAccounts() {
        Account[] acctList = [select Id , Description from Account order by CreatedDate asc limit 5];
        for (Account acc : acctList) {
            acc.Description = 'Heritage Account';
        }
       update acctList;
        
        for(Account acc : acctList) {
            system.debug(acc.Id +' '+ acc.Description);
        }
        
        
    }

}