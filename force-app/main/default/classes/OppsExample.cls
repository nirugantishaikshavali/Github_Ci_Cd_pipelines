public virtual class OppsExample {
    public String OppName;
    public Decimal Amount;
    //constructor
    public OppsExample(String oppName,Decimal Amount){
        this.OppName=oppName;
        this.Amount=Amount;
    }
    
    //Method
    public void displayDetails(String msg){
        System.debug('Opportunity Name '+OppName);
        System.debug('Amount '+Amount);
        System.debug('Msg '+msg);
    }
    
    

}