class CommentData {
  CommentData({
    this.profilePic,
    this.name,
    this.uid,
    this.text,
    this.commentId,
    this.datePublished,
    this.timeStamp,
  });

  String? profilePic;
  String? name;
  String? uid;
  String? text;
  String? commentId;
  DateTime? datePublished;
  dynamic timeStamp;

  factory CommentData.fromJson(Map<String, dynamic> json) => CommentData(
    profilePic: json["profilePic"] == null ? null : json["profilePic"],
    name: json["name"] == null ? null : json["name"],
    uid: json["uid"] == null ? null : json["uid"],
    text: json["text"] == null ? null : json["text"],
    commentId: json["commentId"] == null ? null : json["commentId"],
    datePublished: json["datePublished"] == null ? null : DateTime.parse(json["datePublished"].toDate().toString()),
    timeStamp: json["timeStamp"] == null ? null : json["timeStamp"] as dynamic,
  );

  Map<String, dynamic> toJson() => {
    "profilePic": profilePic == null ? null : profilePic,
    "name": name == null ? null : name,
    "uid": uid == null ? null : uid,
    "text": text == null ? null : text,
    "commentId": commentId == null ? null : commentId,
    "datePublished": datePublished == null ? null : datePublished,
    "timeStamp": timeStamp == null ? null : timeStamp,
  };

  CommentData copyWith({
    String? profilePic,
    String? name,
    String? uid,
    String? text,
    String? commentId,
    DateTime? datePublished,
    dynamic timeStamp,
  }) {
    return CommentData(
      profilePic: profilePic ?? this.profilePic,
      name: name ?? this.name,
      uid: uid ?? this.uid,
      text: text ?? this.text,
      commentId: commentId ?? this.commentId,
      datePublished: datePublished ?? this.datePublished,
      timeStamp: timeStamp ?? this.timeStamp,
    );
  }
}