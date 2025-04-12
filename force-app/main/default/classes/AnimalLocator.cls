public with sharing class AnimalLocator {
    public static String getAnimalNameById(Integer ID) {

        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/'+ID);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
		System.debug(response);
    
            Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            //System.debug(result);
            Map<String,Object> animalList = (Map<String, Object>) result.get('animal');
            return (String) animalList.get('name');
       
    }
    
    public static HttpResponse getAnimalNameById2(Integer ID) {

        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/'+ID);
        request.setMethod('GET');
        HttpResponse response = http.send(request);

        return response;
    }
}