import 'package:flutter/material.dart';
import 'package:notes_ui/models/notes.dart';
import 'package:notes_ui/services/api_services.dart';

class NotesProvider with ChangeNotifier {
  List<Notes> notes = [];
  void addNotes(Notes note) {
    notes.add(note);

    notifyListeners();
    ApiService.addNote(note);
  }

  void updateNote(Notes note) {
    int indexOfNote =
        notes.indexOf(notes.firstWhere((element) => element.id == note.id));
    notes[indexOfNote] = note;
    notifyListeners();
  }

  void deleteNotes(Notes note) {
    int indexOfNote =
        notes.indexOf(notes.firstWhere((element) => element.id == note.id));
    notes.removeAt(indexOfNote);
    notifyListeners();
  }
}
