public class YouTubeController{
    private static final String SEARCH_URL = 'https://www.googleapis.com/youtube/v3/search';
    private static final String API_KEY = 'AIzaSyC60-a9ziN9zLIcb9ueYv2-IwS03CnYgI4'; //API_KEY
    
    //Fetching youtube data by given search string
    @AuraEnabled
    public static List<YouTubeWrapper> searchVideos(string searchString){
        //If no search keywords found then it will search for salesforce keyword
        searchString = searchString == null ? 'salesforce' : searchString ;
        
        //Making Http request to google apis
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        HttpResponse res = null;
        String endpoint = SEARCH_URL +
            '?part=snippet' +
            '&maxResults=20' +
            '&type=video' +
            '&q=' + EncodingUtil.urlEncode(searchString, 'UTF-8') +
            '&key=' + API_KEY;
            
        req.setEndPoint(endpoint);
        req.setMethod('GET');
        res = http.send(req);
        
        //Deserializing json data
        YouTubeResult.Response response = (YouTubeResult.Response)JSON.deserialize(res.getBody(), YouTubeResult.Response.class);
        List<YouTubeResult.Item> items = response.items;
        
        //Filling Wrapper Data for lightning component
        List<YouTubeWrapper> LstYTWrapper = new List<YouTubeWrapper>();
        For( YouTubeResult.Item itemObj : items ){
            YouTubeWrapper YuTuWr = new YouTubeWrapper();
            YuTuWr.videoId = itemObj.id.videoId;
            YuTuWr.title = itemObj.snippet.title;
            YuTuWr.Description = itemObj.snippet.description;
            YuTuWr.thumbnails = itemObj.snippet.thumbnails.medium.url;            
            YuTuWr.channelTitle = itemObj.snippet.channelTitle ;
            YuTuWr.publishedAt = itemObj.snippet.publishedAt+'';
            LstYTWrapper.add(YuTuWr);
        }
        return LstYTWrapper;
    }    
    
    //Function for share youtube link to chatter
    @AuraEnabled
    public static void shareOnChatter(string chatterText,String youTubeUrl){
        chatterText  = chatterText == null ? '' : chatterText ;
        FeedItem post = new FeedItem();
        post.ParentId = userinfo.getUserId();
        post.Body = chatterText;
        post.LinkUrl = youTubeUrl;
        insert post;
    }

    public class YouTubeWrapper{
        @AuraEnabled public String videoId { get; set; } 
        @AuraEnabled public String Description { get; set; }
        @AuraEnabled public String thumbnails{ get; set; }
        @AuraEnabled public String title { get; set; }
        @AuraEnabled public String channelTitle { get; set; }
        @AuraEnabled public String publishedAt  { get; set; }
    }
}