class Note {
  int? id;
  String? title;
  String? note;
  String? dateTimeEdit;
  String? dateTimeCreated;

  Note({
    this.id,
    this.title,
    this.note,
    this.dateTimeEdit,
    this.dateTimeCreated,
  });

  Note.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    note = json['note'];
    dateTimeEdit = json['dateTimeEdit'];
    dateTimeCreated = json['dateTimeCreated'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'note': note,
      'dateTimeEdit': dateTimeEdit,
      'dateTimeCreated': dateTimeCreated,
    };
  }
}
