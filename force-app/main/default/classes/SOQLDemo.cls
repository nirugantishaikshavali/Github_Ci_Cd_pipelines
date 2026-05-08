public class SOQLDemo {
        public static void query(String ObjectApiName,
                             String ObjectFields,
                             String FilterData,
                             Integer num,
                             Map<String, Object> bindParams){
                               
        String queryString='select ' +ObjectFields+' from '+ ObjectApiName+' where '+FilterData +' limit '+num;
         //System.debug(queryString);
        //List<sObject>results=Database.query(queryString);
        List<sObject>results=Database.queryWithBinds(queryString,bindParams,AccessLevel.USER_MODE);

        for(sObject s : results){
    		System.debug(s.get('Id'));
            System.debug(s);
}

    }

}