declare module "@salesforce/apex/YouTubeController.searchVideos" {
  export default function searchVideos(param: {searchString: any}): Promise<any>;
}
declare module "@salesforce/apex/YouTubeController.shareOnChatter" {
  export default function shareOnChatter(param: {chatterText: any, youTubeUrl: any}): Promise<any>;
}
