public with sharing class BulkAPIService {

    @AuraEnabled
    public static String processFileWithBulkAPI(String fileId) {
        // Enqueue job and return message
        System.enqueueJob(new BulkApiProcessor(fileId));
        return 'File submitted for Bulk API processing';
    }

    // NEW: Check Job Status
    @AuraEnabled(cacheable=false)
    public static String checkJobStatus(String jobId) {
        HttpRequest req = new HttpRequest();
        req.setEndpoint(Url.getOrgDomainUrl().toExternalForm() + 
            '/services/data/v64.0/jobs/ingest/' + jobId);
        req.setMethod('GET');
        req.setHeader('Authorization', 'Bearer ' + UserInfo.getSessionId());

        Http http = new Http();
        HttpResponse res = http.send(req);

        return res.getBody();
    }
}