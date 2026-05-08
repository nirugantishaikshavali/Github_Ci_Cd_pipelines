public class Constructor {

    // Instance variable
    public String companyName;

    // Constructor
    public Constructor(String companyName){
        System.debug('Company Name inside constructor: ' + companyName);
        this.companyName = companyName;
    }

    // Method
    public void display_text(){
        System.debug('Company Name outside constructor: ' + companyName);
    }
    
    
}