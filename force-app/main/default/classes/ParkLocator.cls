public class ParkLocator {
    public static String[] country(String args) {
        ParkService.ParksImplPort x = new ParkService.ParksImplPort();
 
        return x.byCountry(args);
    }
}