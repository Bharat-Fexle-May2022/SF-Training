public with sharing class Day13_StaticAndInstanceMethods {

    public static boolean firstRun = true;

    public class RGB {

        Integer red;
        Integer green;
        Integer blue;

        public RGB(Integer red, Integer green, Integer blue) {
            this.red = red;
            this.green = green;
            this.blue = blue;

            System.debug('This is instance method.');

            // System.debug(red);
            // System.debug(green);
            // System.debug(blue);
        }
     }

   static Map<String, RGB> colorMap = new Map<String, RGB>();

    static {
        colorMap.put('red', new RGB(255, 0, 0));
        colorMap.put('cyan', new RGB(0, 255, 255));
        colorMap.put('magenta', new RGB(255, 0, 255));
        System.debug('static');
    }
}