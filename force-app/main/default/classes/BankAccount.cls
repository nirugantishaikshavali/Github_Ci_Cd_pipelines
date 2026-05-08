public virtual class BankAccount {

    public String accountHolderName;
    public Decimal balance;

    public BankAccount(String accountHolderName, Decimal balance){
        this.accountHolderName = accountHolderName;
        this.balance = balance;
    }

    public void deposit(Decimal amount){
        this.balance += amount;
    }

    public void withdraw(Decimal amount){
        this.balance -= amount;
    }

    public virtual void getAccountDetails(){
        System.debug('Account Holder: ' + this.accountHolderName);
        System.debug('Account Balance: ' + this.balance);
    }

    public virtual Decimal calculateInterest(){
        return 0;
    }
}