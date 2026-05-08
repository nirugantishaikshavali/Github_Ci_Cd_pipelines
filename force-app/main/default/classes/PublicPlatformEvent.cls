public with sharing class PublicPlatformEvent {

    public static void publishEvents() {

        List<Order_Detail__e> orderDetailListEvent = new List<Order_Detail__e>();

        orderDetailListEvent.add(
            new Order_Detail__e(
                Order_Number__c ='ORD300',
                Generate_Invoice__c=true
            )
        );

        orderDetailListEvent.add(
            new Order_Detail__e(
                Order_Number__c ='ORD302',
                Generate_Invoice__c=true
            )
        );

        orderDetailListEvent.add(
            new Order_Detail__e(
                Order_Number__c ='ORD400',
                Generate_Invoice__c=false
            )
        );

        PublishPlatformEventCallback callbackInstance=new PublishPlatformEventCallback();

        List<Database.SaveResult> srList = EventBus.publish(orderDetailListEvent,callbackInstance);

        for(Database.SaveResult srItem : srList){
            if(srItem.isSuccess()){
                System.debug('Platform Event Published Successfully');
            } else {
                for(Database.Error errorDetail : srItem.getErrors()){
                    System.debug('Error Details: ' + errorDetail.getMessage());
                }
            }
        }
    }
}