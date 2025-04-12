public with sharing class StoreMap {

    @AuraEnabled(cacheable=true)
    public static String callMyStoreModel(String storeId) {
        String MS_URL = 'https://b966-2603-8081-2800-4ed2-b99e-9dbd-5711-4a9a.ngrok-free.app/myStoreModel';
        try {
            Http http = new Http();
            HttpRequest req = new HttpRequest();
            HttpResponse res = new HttpResponse();
            req.setEndpoint(MS_URL);
            String jsonBody =  '{ "id" : '+Integer.valueOf(storeId)+'}';
            req.setBody(jsonBody);
            req.setMethod('GET');
            req.setHeader('Content-Type', 'application/json');
            system.debug('calling mule mystoremodel id !');  
            system.debug(res.getBody());
            res = http.send(req);
            if(res.getStatusCode() == 200) {
                return res.getBody();
            } else {
                String errorResp =  '{"error": "Error calling mulesoft - apex StoreMap callMyStoreModel class", "errorCode" :' +res.getStatusCode()+'}';
                return errorResp;    
            }   
        } catch (Exception e) {
            return '{"error:"' + '"' + e.getMessage()+'"}';
        }
    }

    @AuraEnabled(cacheable=true)
    public static String callSaveStoreApi(String data) {

        String MS_URL_SAVE = 'https://b966-2603-8081-2800-4ed2-b99e-9dbd-5711-4a9a.ngrok-free.app/store-layout-save-area';
        if (data .length() == 0) {
            return '{"error": "could not gather save map layout data from frontend, retry to get data"}';
        }
        try {
            Http http = new Http();
            HttpRequest req = new HttpRequest();
            req.setEndpoint(MS_URL_SAVE);
            req.setMethod('POST');
            req.setHeader('Content-Type', 'application/json');
            req.setBody(data);

            HttpResponse res = http.send(req);
            if(res.getStatusCode() == 200) {
                return res.getBody();
            } 
            String errorResp =  '{"error": "Error calling mulesoft - apex StoreMap callSaveStoreApi class", "errorCode" :' +res.getStatusCode()+'}';
            return errorResp;
        }
        catch (Exception ex) {
                return '{"error:"' + '"' + ex.getMessage()+'"}';
        } 
    }

}