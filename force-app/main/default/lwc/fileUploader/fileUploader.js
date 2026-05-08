import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import processFileWithBulkAPI from '@salesforce/apex/BulkAPIService.processFileWithBulkAPI';

export default class FileUploader extends LightningElement {

    isProcessing = false;
    selectedFile;
    statusMessage = "";
    statusMessageClass = "";

    // Disable button logic
    get isSubmitButtonDisabled() {
        return !this.selectedFile || this.isProcessing;
    }

    // File upload handler
    handleUploadFinished(event) {
        const uploadedFiles = event.detail.files;
        console.log("UploadFiles",uploadedFiles, JSON.stringify(uploadedFiles));

        if (uploadedFiles.length > 0) {
            const file = uploadedFiles[0];
            this.selectedFile = {
                title: file.name,
                documentId: file.documentId
            };

            this.statusMessage = 'File uploaded successfully! Ready for processing.';
            this.statusMessageClass = 'slds-notify slds-notify_alert slds-m-top_medium slds-theme_success';

            this.showToast('Success', this.statusMessage, 'success');
        }
    }

   
    handleSubmitForProcessing() {
    this.isProcessing = true;

    this.statusMessage = 'Submitting file for processing...';
    this.statusMessageClass = 'slds-notify slds-notify_alert slds-m-top_medium slds-theme_info';

    processFileWithBulkAPI({
        fileId: this.selectedFile.documentId
    })
    .then(() => {
        this.statusMessage = 'File submitted successfully! Processing in background...';
        this.statusMessageClass = 'slds-notify slds-notify_alert slds-m-top_medium slds-theme_warning';

        this.showToast('Info', this.statusMessage, 'info');
    })
    .catch(error => {
        this.statusMessage = 'Error while submitting file';
        this.statusMessageClass = 'slds-notify slds-notify_alert slds-m-top_medium slds-theme_error';

        console.error(error.body?.message || error.message);
        this.showToast('Error', this.statusMessage, 'error');
    })
    .finally(() => {
        this.isProcessing = false;
    });
}

    // Clear selected file
    handleClearSelection() {
        this.selectedFile = null;
        this.statusMessage = '';
        this.statusMessageClass = '';
    }

    // Toast helper
    showToast(title, message, variant) {
        const event = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant
        });
        this.dispatchEvent(event);
    }
}