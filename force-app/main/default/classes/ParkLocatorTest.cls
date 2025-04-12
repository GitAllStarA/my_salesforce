@isTest
public with sharing class ParkLocatorTest {
    @isTest static void testCallout() {
        Test.setMock(WebServiceMock.class, new ParkServiceMock());
        String x = 'India';
        String[] result = ParkLocator.country(x);
        String[] val =new String[] {'Anamudi Shola National Park', 'Anshi National Park', 'Bandipur National Park'};
        System.assertEquals(val, result);
    }
}