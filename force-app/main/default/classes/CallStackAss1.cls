public class CallStackAss1 {
    
    public static String methodA(){
        System.debug('Inside Method A');
        methodE();
        methodB();
        methodD();
        return 'End A';
    }
    
    public static String methodB(){
        System.debug('Inside Method B');
        methodC();
        return 'End B';
    }
    public static String methodC(){
        System.debug('Inside Method C');
        return 'End C';
    }
    public static String methodD(){
        System.debug('Inside Method D');
        return 'End D';
    }
    public static String methodE(){
        System.debug('Inside Method E');
        return 'End E';
    }
}