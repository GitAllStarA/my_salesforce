public class ApiCalls {

    private static String callout = 'callout:ngrok_sbmssf'; 

    @AuraEnabled(cacheable=true)
    public static String callApi() {
    try { 
        Http http = new HTTP();
        HttpRequest req = new HttpRequest();
        HttpResponse res = new HttpResponse();
        req.setEndpoint('https://dummyjson.com/todos');
        req.setMethod('GET');
        req.setHeader('Content-Type','application/json');
        res = http.send(req);
        system.debug('hello world!');  
        system.debug(res.getBody());
        if (res.getStatusCode() == 200) {
            return res.getBody(); 
        } else {
            return '{"error": "Failed to fetch data, Status: ' + res.getStatusCode() + '"}';
        }
    } catch (Exception e) {
            return '{"error": "Exception occurred: ' + e.getMessage() + '"}';
    }
        
    }
    @AuraEnabled(cacheable=true)
    public static String sbmssfCallApi() {
        try {
            Http http = new HTTP();
            HttpRequest req = new HttpRequest();
            HttpResponse res = new HttpResponse();
            req.setEndpoint(callout+'/myStoreModel');
            req.setMethod('GET');
            req.setHeader('Content-Type','application/json');
            String jsonBody = '{"id":1}';
            req.setBody(jsonBody);
            res = http.send(req);
            system.debug('hello world!');  
            system.debug(res.getBody());
            if (res.getStatusCode() == 200) {
                return res.getBody(); 
            } else {
                return '{error": "Failed to fetch data, Status: ' + res.getStatusCode() + '"}';
            }
        }
        catch (Exception ex) {
            return '{"error": "Exception occurred: ' + ex.getMessage() + '"}';
        }
    }

    @AuraEnabled(cacheable=true)
    public static String sbmssfCallApiById(String id) {
        try {
            Http http = new HTTP();
            HttpRequest req = new HttpRequest();
            HttpResponse res = new HttpResponse();
            req.setEndpoint(callout+'/myStoreModel');
            req.setMethod('POST');
            req.setHeader('Content-Type','application/json');
            Integer idVal = Integer.valueOf(id); 
            Map<String,Integer> jsonObj = new Map<String,Integer>();
            jsonObj.put('id', idVal);
            req.setBody(JSON.serialize(jsonObj));
            res = http.send(req);
            system.debug('hello world!');  
            system.debug(res.getBody());
            if (res.getStatusCode() == 200) {
                return res.getBody(); 
            } 
                            return '{"error": "Failed to fetch data, Status: ' + res.getStatusCode() + '"}';
            
        }
        catch (Exception ex) {
            return '{"error": "Exception occurred: ' + ex.getMessage() + '"}';
        }
    }



    @AuraEnabled(cacheable=true)
    public static String callSaveStoreApi(String data) {

        String MS_URL_SAVE = callout+'/store-layout-save-area';
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

            Map<String,Object> errorJson = new Map<String,Object>();
            errorJson.put('erro', 'Error calling mulesoft - apex StoreMap callSaveStoreApi class');
            errorJson.put('errorCode', res.getStatusCode());
            return JSON.serialize(errorJson);
        }
        catch (Exception ex) {
            Map<String,Object> errorJson = new Map<String,Object>();
            errorJson.put('errorCode', ex.getMessage());
            return JSON.serialize(errorJson);
        } 
    }


    @AuraEnabled(cacheable=true)
    public static String callMyStoreModel(String id) {
        String MS_URL = callout+'/myStoreModel';
        if (String.isEmpty(id)) {
            throw new CalloutException('Invalid storeId: Cannot be empty');
        }
        try {
            Http http = new Http();
            HttpRequest req = new HttpRequest();
            HttpResponse res = new HttpResponse();
            req.setEndpoint(MS_URL);
            Map<String,Integer> jsonObj = new Map<String,Integer>();
            Integer idVal = Integer.valueOf(id);
            
            jsonObj.put('id', idVal);
            req.setBody(JSON.serialize(jsonObj));
            
            req.setMethod('POST');
            req.setHeader('Content-Type', 'application/json');
            system.debug('calling mule mystoremodel id !');  
            res = http.send(req);
            if(res.getStatusCode() == 200) {
                system.debug(res.getBody());
                return res.getBody();
            } else {
                Map<String,Object> errorJson = new Map<String,Object>();
                errorJson.put('error', 'Error calling mulesoft - apex StoreMap callMyStoreModel class');
                errorJson.put('errorCodeX',res.getStatusCode());
                return JSON.serialize(errorJson);    
            }   
        } catch (Exception e) {
            Map<String,Object> errorJson = new Map<String,Object>();
            errorJson.put('errorCode', e.getMessage());
            return JSON.serialize(errorJson);
        }
    }
}