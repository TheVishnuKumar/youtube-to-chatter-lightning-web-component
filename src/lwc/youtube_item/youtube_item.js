/**
 * @author Vishnu Kumar
 * @email vishnukumarramawat@gmail.com
 * @desc This JS handle the youtube result item.
*/
import { LightningElement,api } from 'lwc';

export default class Youtube_item extends LightningElement {
    @api item;
    
    /**
     * @author Vishnu Kumar
     * @email vishnukumarramawat@gmail.com
     * @desc This method send the event to parent component with the video Id.
    */
    watchVideo(){
        this.dispatchEvent( new CustomEvent('videochange', {
            detail: {
                videoId: this.item.videoId
            }
        }) );
    }
}