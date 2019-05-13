import { LightningElement,track } from 'lwc';
import searchVideos from '@salesforce/apex/YouTubeController.searchVideos';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class Youtube_screen extends LightningElement {

    //Default search keyword added as 'Salesforce'
    @track searchTxt = 'Salesforce';
    @track result = [];
    @track viewUrl = '';

    doSearch(){
        this.result = [];
        this.viewUrl = '';

        //Getting the timezone from current user's site
        searchVideos({searchString:this.searchTxt})
        .then((result) => {
            this.result = result;

            if( this.result.length > 0 ){
                this.showVideoInIframe(this.result[0].videoId);
            }
        })
        .catch((error) => {
            let message = error.message || error.body.message;
            this.showMessage( { message: message, messageType: 'error', mode: 'pester'} );
        });
    }

    handleFormInput(event){
        this.searchTxt = event.target.value;
    }

    showVideoInIframe(videoId){
        this.viewUrl = 'https://www.youtube.com/embed/'+videoId;
    }

    connectedCallback(){
        this.doSearch();
    }

    showMessage( { title, message, messageType, mode }) {
        this.dispatchEvent(new ShowToastEvent({
            mode,
            title,
            message,
            variant: messageType,
        }));
    }
}