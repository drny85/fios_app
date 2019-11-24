class Note {
  String id;
  String note;
  String author;
  DateTime created;

  Note({this.id, this.note, this.author, this.created});

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['_id'],
      note: json['note'],
      author: json['author'],
      created: DateTime.parse(json['created']),
    );
  }
}
