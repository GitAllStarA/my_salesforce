@RestResource(urlMapping='/Cases/*')
global with sharing class CaseManager {
    

    @HttpGet
    global static Case getCaseById() {
        RestRequest req = RestContext.request;
        //grab case id from endpoint url
        String caseId = req.requestURI.substring(
            req.requestURI.lastIndexOf('/')+1);
        Case result = [Select CaseNumber, Subject, Status, Origin, Priority From Case where Id = :caseId];
        return result;
    }

    // @HttpGet
    // global static List<Case> getCases() {
    //     return [Select CaseNumber, Subject, Status, Origin, Priority From Case order by Origin limit 10];
    // }

    @HttpPost
    global static ID createCase(String subject, String status, String origin, String priority) {
        Case thisCase = new Case(
            Subject = subject, Status = status, Origin = origin, Priority = priority
        );
        insert thisCase;
        return thisCase.Id;
    }
    
    @HttpDelete
    global static void deleteCase() {
        RestRequest request = RestContext.request;
        String caseId = request.requestURI.substring(request.requestURI.lastIndexOf('/')+1);
        Case thisCase = [Select Id from Case where Id = :caseId];
        delete thisCase;
    }

    @HttpPut
    global static ID upsertCase(String subject, String status, String origin, String priority, String id) {
        Case thisCase = new Case(
            Id = id,
            Subject = subject,
            Status = status,
            Origin = origin,
            Priority = priority
        );
         // Match case by Id, if present.
        // Otherwise, create new case.
        upsert thisCase;
        return thisCase.Id;
    }

    @HttpPatch
    global static ID updateCase() {
        RestRequest request = RestContext.request;
        String caseId = request.requestURI.substring(request.requestURI.lastIndexOf('/')+1);
        Case thisCase = [Select Id from Case where Id = :caseId];
        //Deserialize the JSON
        Map<String, Object> params = (Map<String, Object>) JSON.deserializeUntyped(request.requestbody.toString()); 
        //Iterate over the each param field and value
        for(String fieldName: params.keySet()) {
            //Set field and value on the case sObject
            thisCase.put(fieldName, params.get(fieldName));
        }
        update thisCase;
        return thisCase.Id;
    }

}