public with sharing class userUtility {
    public userUtility() {

    }

    public static void selectUserByProfile(String profileName){
        List<User> userList = [select Id,Name from User Where Profile.Name =: profileName];
    }
}