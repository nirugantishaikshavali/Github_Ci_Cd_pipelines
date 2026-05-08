public with sharing class BulkApiProcessor implements Queueable, Database.AllowsCallouts {

    private Id fileId;

    // Constructor to receive fileId
    public BulkApiProcessor(Id fileId) {
        this.fileId = fileId;
    }

    public void execute(QueueableContext context) {
    System.debug('🔥 QUEUEABLE STARTED 🔥');

    ContentVersion cv = [
        SELECT VersionData 
        FROM ContentVersion 
        WHERE ContentDocumentId = :fileId 
        AND IsLatest = true 
        LIMIT 1
    ];

    System.debug('File Retrieved');

    String csvContent = cv.VersionData.toString();
    System.debug('CSV Content Length: ' + csvContent.length());

    String result = bulkAPIOperation(csvContent);
    System.debug('Bulk API Result: ' + result);
}
   

    public String bulkAPIOperation(String csvContent) {
    try {
        String jobId = createBulkAPIJob();

        uploadCSVData(jobId, csvContent);

        closeBulkAPIJob(jobId);

        System.debug('Bulk API Job Id: ' + jobId);

        return jobId; // 🔥 RETURN JOB ID (IMPORTANT)

    } catch (Exception e) {
        throw new BulkAPIException('Bulk API Processing Failed: ' + e.getMessage());
    }
}

    // Create Bulk API Job
    public String createBulkAPIJob() {
        HttpRequest req = new HttpRequest();
        req.setEndpoint(Url.getOrgDomainUrl().toExternalForm() + '/services/data/v64.0/jobs/ingest');
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/json');
        req.setHeader('Authorization', 'Bearer ' + UserInfo.getSessionId());

        Map<String, Object> requestBody = new Map<String, Object>{
            'operation' => 'insert',
            'object' => 'Account',
            'contentType' => 'CSV',
            'lineEnding' => 'LF'
        };

        req.setBody(JSON.serialize(requestBody));

        Http http = new Http();
        HttpResponse res = http.send(req);

        if (res.getStatusCode() != 200 && res.getStatusCode() != 201) {
            throw new BulkAPIException('Job Creation Failed: ' + res.getBody());
        }

        Map<String, Object> resBody = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
        String jobId = (String) resBody.get('id');

        return jobId;
    }

    // Upload CSV Data
    public void uploadCSVData(String jobId, String csvContent) {
        HttpRequest req = new HttpRequest();
        req.setEndpoint(Url.getOrgDomainUrl().toExternalForm() + '/services/data/v64.0/jobs/ingest/' + jobId + '/batches');
        req.setMethod('PUT');
        req.setHeader('Content-Type', 'text/csv');
        req.setHeader('Authorization', 'Bearer ' + UserInfo.getSessionId());

        req.setBody(csvContent);

        Http http = new Http();
        HttpResponse res = http.send(req);

        if (res.getStatusCode() != 201) {
            throw new BulkAPIException('CSV Upload Failed: ' + res.getBody());
        }
    }

    // Close Job
    public void closeBulkAPIJob(String jobId) {
        HttpRequest req = new HttpRequest();
        req.setEndpoint(Url.getOrgDomainUrl().toExternalForm() + '/services/data/v64.0/jobs/ingest/' + jobId);
        req.setMethod('PATCH');
        req.setHeader('Content-Type', 'application/json');
        req.setHeader('Authorization', 'Bearer ' + UserInfo.getSessionId());

        Map<String, String> body = new Map<String, String>{
            'state' => 'UploadComplete'
        };

        req.setBody(JSON.serialize(body));

        Http http = new Http();
        HttpResponse res = http.send(req);

        if (res.getStatusCode() != 200) {
            throw new BulkAPIException('Job Close Failed: ' + res.getBody());
        }
    }

    // Custom Exception
    public class BulkAPIException extends Exception {}
}