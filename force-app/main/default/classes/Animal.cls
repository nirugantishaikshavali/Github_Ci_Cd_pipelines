public class Animal {
    public String name = 'Max';
    public Id recordId = 'a01g50000080o10AAA';
    public Integer age = 5;
    
    public static final decimal pi_value=45.6;
    
    public void method1(Integer num1,Integer num2){
        System.debug('Number1 ' + num1);
        System.debug('Number2 ' + num2);
    }
    
    public void call_method(){
        System.debug('Calling Method');
        add(45,56);
    }
    
    public Void add(Integer num1,Integer num2){
        Integer sum=num1+num2;
        System.debug(sum);
    }
    
    
    public Integer mul(Integer num1,Integer num2){
        Integer multiple=num1*num2;
        return multiple;
    }
    
    
    public Static Void display_msg(){
        System.debug('Static Method');
    }
    
}