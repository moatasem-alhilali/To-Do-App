import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';
import 'package:todo/db/db_helper_note.dart';
import 'package:todo/models/note.dart';

class NoteController extends GetxController {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  Future clear() async {
    titleController.text = '';
    contentController.text = '';
  }

  final RxList<Note> notesList = <Note>[].obs;

  void readNotes() async {
    return await DBHelperNotes.getAllData().then((value) {
      notesList.assignAll(value.map((e) => Note.fromJson(e)).toList());
      // update();
    });
  }

  bool isEmpty() {
    if (notesList.isEmpty)
      return true;
    else
      return false;
  }

  Future addNote(context) async {
    String title = titleController.text;
    String content = contentController.text;
    if (title.isEmpty) {
      title = 'بدون عنوان';
    }
    Note note = Note(
      title: title,
      note: content,
      dateTimeEdit: DateFormat('MMM dd, yyyy HH:mm:ss').format(DateTime.now()),
      dateTimeCreated:
          DateFormat('MMM dd, yyyy HH:mm:ss').format(DateTime.now()),
    );

    DBHelperNotes.addNote(note).then((value) {
      titleController.text = '';
      contentController.text = '';
      readNotes();
      Navigator.pop(context);
    });
  }

  void deleteNote(int id) async {
    Note note = Note(id: id,);
    await DBHelperNotes.deleteNote(note).then((value) {
      readNotes();
    });
  }

  void deleteAllNotes() async {
    await DBHelperNotes.deleteAllNotes().then((value) {
      readNotes();
    });
  }

  Future updateNote({required Note note}) async {
    DBHelperNotes.updateNote(note).then((value) {
      titleController.text = '';
      contentController.text = '';
      readNotes();
    });
  }

  void shareNote(String title, String content) {
    Share.share('$title \n$content');
  }
}
