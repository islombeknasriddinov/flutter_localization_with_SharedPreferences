class Note {
  String? userId;
  String? title;
  String? content;
  String? date;

  Note(String userId, String title, String content, String date) {
    this.userId = userId;
    this.title = title;
    this.content = content;
    this.date = date;
  }

  Note.fromJson(Map<String, dynamic> json)
      : userId = json['userId'],
        title = json['title'],
        content = json['content'],
        date = json['date'];

  Map<String, dynamic> toJson() => {
    'userId':userId,
    'title':title,
    'content':content,
    'date':date
  };
}
