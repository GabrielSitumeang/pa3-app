import 'package:flutter/cupertino.dart';
import 'package:pa3/models/note.dart';

class NotesOperation with ChangeNotifier {
  //List of note
  List<Note> _notes = [];

  List<Note> get getNotes {
    return _notes;
  }

  NotesOperation() {
    addNewNote('First Note', 'First Note Description');
  }

  void addNewNote(String title, String description) {
    //Note object
    Note note = Note(title, description);
    _notes.add(note);
    notifyListeners();
  }

  void updateNote(Note note, String newTitle, String newDescription) {
    note.title = newTitle;
    note.description = newDescription;
    notifyListeners();
  }

  void deleteNote(Note note) {
    _notes.remove(note);
    notifyListeners();
  }
  
}
