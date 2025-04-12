public with sharing class ApexCollections {
    public ApexCollections() {

    }

    public void apexMethods() {

        //List
        List<String> color = new List<String>();

        color.add('red');
        color.add('yellow');
        color.add('green');

        String[] moreColors = new List<String> {'white','black','purple','red'};

        String getColor = color.get(0);
        String getMoreColors = moreColors[3];
        System.assertEquals(getColor, getMoreColors);

        for (String variable : color) {
            System.debug(variable);
        }

        //Set
        Set<String> mySet = new Set<String>();
        mySet.add('one');
        mySet.add('two');
        mySet.add('two');

        System.assert(mySet.contains('one'));
        mySet.remove('one');
        System.assert(mySet.size() == 1);
        

        //Map
        Map<String, String> country_currencies = new Map<String, String>();
        Map<ID, Set<String>> m = new Map<ID, Set<String>>();


        Map<String, String> mapS = new Map<String, String>();
        mapS.put('a','smallA');
        mapS.put('A','capitalA');

        System.assert(mapS.containsKey('a'));

        Map<String, String> map2 = new Map<String, String>{'a' => 'b', 'c' => 'd'.toUpperCase()};
        System.assertEquals('D', mapS.get('c'));

    }
}