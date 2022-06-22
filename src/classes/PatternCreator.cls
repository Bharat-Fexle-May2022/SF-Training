public with sharing class PatternCreator {
    public PatternCreator() {
        
    }
    public static void LeftTriangleStarPattern() {
        for(Integer i = 1; i <= 5; i++) {
            String s = ' ';
            for(Integer j = 1; j <= 5; j++) {
                if(j >= 6 - i) {
                    s = s + '*';
                }
                else {
                    s = s + '_';
                }
            }
            System.debug(s);
        }
    }

    public static void DownwardTriangleStarPattern() {
        for(Integer i = 1; i <= 5; i++) {
            String s = ' ';
            for(Integer j = 5; j >= i; j--) {
                s = s + '*';
            }
            System.debug(s);
        }
    }

    public static void ReservedPyramidStarPattern() {
        for(Integer i = 1; i <= 5; i++) {
            String s = ' ';
            for(Integer j = 1; j < i; j++) {
                s = s + '_';
            }
            for(Integer k = 5; k >= i; k--) {
                s = s + '*_';
            }
            System.debug(s);
        }
    }

    public static void RightPascalTriangleProgram () {
        for(Integer i = 1; i <= 5; i++) {
            String s = ' ';
            for(Integer j = 1; j <= i; j++) {
                s = s + '*';
            }
            System.debug(s);
        }
        for(Integer k = 1; k <= 5; k++) {
            String s = ' ';
            for(Integer l = 5; l > k; l--) {
                s = s + '*';
            }
            System.debug(s);
        }
    }

    public static void LeftPascalTriangleProgram() {
        for(Integer i = 1; i <= 5; i++) {
            String s = ' ';
            for(Integer j = 5; j > i; j--) {
                s = s + '_';
            }
            for(Integer k = 1; k <= i; k++) {
                s = s + '*';
            }
            System.debug(s);
        }
        for(Integer l = 1; l <= 5; l++) {
            String s = ' ';
            for(Integer m = l; m <= 5; m++) {
                s = s + ' ';
            }
            for(Integer n = 1; n <= l; n++) {
                s = s + '* ';
            }
        }
    }
}