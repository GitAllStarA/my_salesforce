@isTest
global class CalculatorCalloutMock implements WebServiceMock {
    global void doInvoke(
    Object stub, Object request, Map<String, Object> response, String endpoint, String soapAction, String requestName, String responeNS, String responseName
        , String responseType) {
            calculatorServices.doAddResponse resp_x = new calculatorServices.doAddResponse();
            resp_x.return_x = 3.0;
            
    		response.put('resp_x',resp_x);
        }
    

}