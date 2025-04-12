global class DeDup implements Database.Batchable<SObject>, Database.Stateful {
    global Set<String> name;
    global Database.QueryLocator start(Database.BatchableContext BC) {
        return Database.getQueryLocator([Select id, Name from Contact where Email = null]);
    }
    
    global void execute(Database.BatchableContext BC, List<Contact> contacts) {
        Set<String> nameSet  = new Set<String>();
        for(Contact cx : contacts) {
            nameSet.add(cx.Name);
        }
        
        System.debug(nameSet);
        List<Contact> cList = [Select id, Name from Contact where Name In :nameSet];
        List<Contact> dedupList = new List<Contact>();
        for(Contact cx : contacts) {
            for(Contact cx2 : cList) {
                if(cx.Name == cx2.Name) {
                    dedupList.add(cx2);
                }
            }
        }
        System.debug('->>>>>>>>>>>>>>>>>>>>>>>'+dedupList);
        delete dedupList;
        
    }
    
    global void finish(Database.BatchableContext BC) {
        
    }

}