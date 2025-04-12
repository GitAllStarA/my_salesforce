public with sharing class StringArrayTest {
    public StringArrayTest() {

    }

    public static void printList(List<String> strList){
        for(String s : strList){
            System.debug(s);
        }
    }

    public static List<String> generateStringArray(Integer n){
        List<String> s = new List<String>();
        for (Integer i = 0; i < n; i++) {
            s.add('Test '+i);
        }
        printList(s);
        return s;
    }
}