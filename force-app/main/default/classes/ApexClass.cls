public class ApexClass {
    static final Integer INT_CONSTANT;
    
    public static void apexMethod() {
        system.debug('hello world!');  
    }
    
    public static String getName() {
        return 'hey salesforce';
    }
    
	public static void conditions(Integer x) {
        if(x > 1000){
            system.debug('x is greater');
        } else {
             system.debug('x is not greater');
        }
        
    }
    
    public static void loop(Integer x){
        Integer c = 0;
        while(c<x){
            system.debug(c);
            c++;
        }
        
        do{
            system.debug(c);
            c++;
        } while(c<x);        
        
        
        for(Integer c2 = 0; c2 < 10 ; c2++) {
            system.debug('hey : '+c2);
            
        }
        
        Integer[] listx = new Integer[]{1,2,3,4,5,6,7,8,9,10};
            
        for(Integer i : listx) {
             system.debug(i);   
        }
  
    }
  
}