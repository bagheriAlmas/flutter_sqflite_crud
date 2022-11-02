String tableNotes = 'tbl_notes';

class Note {
  final int? id;
  final String? title;
  final String? content;

  Note({this.id, this.title, this.content});

  Map<String, Object?> toJson() => {
        NotesFields.id: id,
        NotesFields.title: title,
        NotesFields.content: content
      };

  static Note fromJson(Map<String,Object?> json) =>Note(
    id:json[NotesFields.id] as int?,
    title:json[NotesFields.title] as String,
    content:json[NotesFields.content] as String,
  );

  Note copy({int? id,String? title,String? content}) => Note(
    id: id ?? this.id,
    title: title ?? this.title,
    content: content ?? this.content,
  );
}

class NotesFields {
  static final List<String> values = [id, title, content];
  static const String id = '_id';
  static const String title = '_title';
  static const String content = '_content';
}
