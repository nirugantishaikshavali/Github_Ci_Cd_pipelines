public class CallStackDemo {
    
    public void methodA(){
        System.debug('Inside Method A');
        methodB();
        System.debug('A');
    }
    
    public void methodB(){
        System.debug('Inside Method B');
        methodC();
        System.debug('B');
    }
    
    public void methodC(){
        System.debug('Inside Method C');
            methodD();
        System.debug('C');

    }
    public String methodD(){
        System.debug('Inside Method D');
        methodE();
        System.debug('Ddffg');
        return 'End';

    }
    public void methodE(){
        System.debug('Inside Method E');
        System.debug('E');

    }
}