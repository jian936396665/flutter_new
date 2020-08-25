class FeedDataModel{

  List<FeedModel> data;

  FeedDataModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<FeedModel>();
      new List.from(json['data']).forEach((v) {
        if(v.containsKey("content")){
          Map<String, dynamic> contentMap = v["content"];
          if(contentMap.containsKey("cover")) {
            data.add(new FeedModel.fromJson(new Map<String, dynamic>.from(v)));
          }
        }
      });
    }
  }
}

class FeedModel{
  Content content;

  FeedModel.fromJson(Map<String, dynamic> json){
    if(json.containsKey("content")) {
      content = new Content.fromJson(json["content"]);
    }
  }

  FeedModel(this.content);
}

class Content{
  Cover cover;
  String moment_content;

  Content(this.cover, this.moment_content);

  Content.fromJson(Map<String, dynamic> json){
    cover = new Cover.fromJson(json["cover"]);
    moment_content = json["moment_content"];
  }
}

class Cover{
  String thumbnail_url;

  Cover(this.thumbnail_url);

  Cover.fromJson(Map<String, dynamic> json){
    if(json==null){
      thumbnail_url = "";
    }else{
      thumbnail_url = json["thumbnail_url"];
    }
  }
}