class Noti {
  String title;
  String content;

  Noti({this.title, this.content});

  factory Noti.fromJson(Map<dynamic, dynamic> parsedJson) {
    return Noti(title: parsedJson['title'], content: parsedJson['context']);
  }
}
