import 'package:flutter/material.dart';
import 'package:notesapp/services/api_service.dart';

import '../models/notes.dart';

class NoteProvider with ChangeNotifier {
  List<Note> notes = [];
  bool isLoading = true;

  NoteProvider() {
    fetchNote();
  }

  void sortName() {
    notes.sort((a,b)=> a.dateadded!.compareTo(b.dateadded!));
  }

  void addNote(Note note) {
    notes.add(note);
    notifyListeners();
    ApiService.addnote(note);
  }

  void updateNote(Note note) {
    int indexOfNote =
        notes.indexOf(notes.firstWhere((element) => element.id == note.id));
    notes[indexOfNote] = note;
    notifyListeners();
  }

  void deleteNote(Note note) {
    int indexOfNote =
        notes.indexOf(notes.firstWhere((element) => element.id == note.id));
    notes.removeAt(indexOfNote);
    notifyListeners();
    ApiService.deletenote(note);
  }

  void fetchNote() async {
    notes = await ApiService.fetchNotes("");
    isLoading = false;
    notifyListeners();
  }
}
