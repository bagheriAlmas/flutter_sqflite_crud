import 'package:flutter/material.dart';
import 'package:flutter_sqflite/db/MyDB.dart';
import 'package:flutter_sqflite/model/Note.dart';

class AddNote extends StatefulWidget {
  Note? note;

  AddNote({Key? key, this.note}) : super(key: key);

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  TextEditingController txtTitle = TextEditingController();
  TextEditingController txtContent = TextEditingController();

  @override
  void initState() {
    txtTitle.text = widget.note?.title ?? "";
    txtContent.text = widget.note?.content ?? "";
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Note"),
      ),
      body: Column(
        children: [
          TextField(
            controller: txtTitle,
          ),
          TextField(
            minLines: 5,
            maxLines: 5,
            controller: txtContent,
          ),
          ElevatedButton(
            onPressed: () {
              widget.note == null ? addNote() : updateNote();
              Navigator.pop(context);
            },
            child: Text(widget.note == null ? "ADD" : "UPDATE"),
          )
        ],
      ),
    );
  }

  void addNote() {
    Note note = Note(title: txtTitle.text, content: txtContent.text);
    MyDB.instance.createNote(note);
  }

  void updateNote() {
    Note note = Note(
        id: widget.note!.id, title: txtTitle.text, content: txtContent.text);
    MyDB.instance.updateNote(note);
  }
}
