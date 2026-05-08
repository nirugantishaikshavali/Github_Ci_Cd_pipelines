public class AccountHelper{
    
        public static String generateKey(Account acc) {
            String name=acc.Name!=null?acc.Name.trim().toLowerCase():'';
            String rating=acc.Rating!=null?acc.Rating.trim().toLowerCase():'';
            return name+'|'+rating;
        }
    
    
    public static Set<String> getNames(List<Account> accList){
        Set<String> names=new Set<String>();
        for(Account acc:accList){
            if(acc.Name!=null){
                names.add(acc.Name);
            }
        }
        return names;
    }
    
    public static Set<String> getRatings(List<Account> accList){
        Set<String> ratings=new Set<String>();
        for(Account acc:accList){
            if(acc.Rating!=null){
                ratings.add(acc.Rating);
            }
        }
        return ratings;
    }

}