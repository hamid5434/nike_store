class CommentEntity {
  int? id;
  String? title;
  String? content;
  String? date;
  String? email;

  CommentEntity({this.id, this.title, this.content, this.date, this.email});

  CommentEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    date = json['date'];
    email = json['author']['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['content'] = this.content;
    data['date'] = this.date;
    data['email'] = this.email;
    return data;
  }
}

class CommentEntitys {
  final List<CommentEntity> list;

  CommentEntitys({required this.list});

  factory CommentEntitys.fromJson(List<dynamic> json) {
    return CommentEntitys(
        list: json.map((e) => CommentEntity.fromJson(e)).toList());
  }
}
