public class AwesomeCalculator {
    public static Double add(Double x, Double y) {
        calculatorServices.CalculatorImplPort cal = new calculatorServices.CalculatorImplPort();
        return cal.doAdd(x,y);
    }
}