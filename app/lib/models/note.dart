class Note {
  String? id;
  String? userid;
  String? title;
  String? content;
  DateTime? created_at;
  DateTime? updated_at;

  Note(
      {this.id,
      this.userid,
      this.title,
      this.content,
      this.created_at,
      this.updated_at});

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      userid: map['userid'],
      title: map['title'],
      content: map['content'],
      created_at: DateTime.tryParse(map['created_at']),
      updated_at: DateTime.tryParse(map['updated_at']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userid': userid,
      'title': title,
      'content': content,
      'created_at': created_at!.toIso8601String(),
      'updated_at': created_at!.toIso8601String(),
    };
  }
}
