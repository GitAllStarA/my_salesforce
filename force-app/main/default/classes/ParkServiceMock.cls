@isTest
global class ParkServiceMock implements WebServiceMock {

    global void doInvoke (
        Object stub, 
        Object request, 
        Map<String, Object> response, 
        String endpoint, 
        String soapAction, 
        String requestName, 
        String responeNS, 
        String responseName,
        String responseType
    ) {
        ParkService.byCountryResponse c_resp_x = new ParkService.byCountryResponse();
        String[] x = new String[] {'Anamudi Shola National Park', 'Anshi National Park', 'Bandipur National Park'};
        c_resp_x.return_x = x;
        response.put('c_resp_x',c_resp_x);
    }
    
}