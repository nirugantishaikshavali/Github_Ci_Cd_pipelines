public class ChildExample extends OppsExample {
    
    public String Acc_name;
    
    public ChildExample(String oppName,Decimal Amount,String name){
        super(oppName,Amount);
        this.Acc_name=name;
    }
    
    public void extraMethod() {
        System.debug('This is child method ->Account_Name'+Acc_name);
    } 
    

}