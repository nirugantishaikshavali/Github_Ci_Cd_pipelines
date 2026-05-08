public with sharing class AssetBatchClass implements Database.Batchable<sObject> {
    public AssetBatchClass() {

    }

    public Database.QueryLocator start(Database.BatchableContext BC) {
        return Database.getQueryLocator([SELECT Id, Name FROM Asset]);
    }

    public void execute(Database.BatchableContext BC, List<Asset> assestList) {
        
    }


    public void finish(Database.BatchableContext bc){
        
    }
}