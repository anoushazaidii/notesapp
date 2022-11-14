import 'package:flutter/material.dart';

import '../models/notes.dart';

class NoteProvider with ChangeNotifier {
  List<Note> notes = [];

  void addNote (Note note) {
    notes.add(note);
    notifyListeners();
  }

  void updateNote (){
    
  }
  
  void deleteNote = {};
}
