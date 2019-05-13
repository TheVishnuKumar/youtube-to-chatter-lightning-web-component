import { LightningElement,api } from 'lwc';

export default class Youtube_item extends LightningElement {
    @api item;

    watchVideo(){
        this.dispatchEvent( new CustomEvent('videochange', {
            detail: {
                videoId: this.item.videoId
            }
        }) );
    }
}