class SessionsData {
  bool? isDone;
  String? title;
  String? url;

  SessionsData({this.isDone, this.title, this.url});

  SessionsData.fromJson(Map<String, dynamic> json) {
    isDone = json["isDone"];
    title = json["title"];
    url = json["url"];
  }
//
}
