@isTest
public with sharing class AnimalLocatorTest {
    @isTest static void testGetCallout() {
        Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock());
        HttpResponse response = AnimalLocator.getAnimalNameById2(1);
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = response.getBody();
        Map<String, Object> jsonMapA = (Map<String, Object>) JSON.deserializeUntyped(actualValue);

        System.debug(response.getBody());
        String expectedValue = '{"animal":{"id": 1,"name":"chicken","eats":"chicken food","says":"cluck cluck"}}';
        Map<String, Object> jsonMapE = (Map<String, Object>) JSON.deserializeUntyped(expectedValue);
        System.assertEquals(jsonMapA, jsonMapE);
        System.assertEquals(200, response.getStatusCode());

        String val = AnimalLocator.getAnimalNameById(1);
        System.assertEquals('chicken', val);

    }
}