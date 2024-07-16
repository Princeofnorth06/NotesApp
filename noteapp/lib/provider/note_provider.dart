import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:noteapp/models/note.dart';
import 'package:noteapp/services/api_services.dart';

class NoteProvider with ChangeNotifier {
  bool isLaoding = true;
  List<Note> notes = [];
  List<bool> isTapped = [];

  NoteProvider() {
    fetchNote();
  }

  void sortnotes() {
    notes.sort((a, b) => b.dateAdded!.compareTo(a.dateAdded!));
  }

  void addNote(Note note) {
    notes.add(note);

    isTapped.add(true);
    sortnotes();
    notifyListeners();
    ApiServices.addNote(note);
  }

  void toggleTapped(int index) {
    if (index >= 0 && index < isTapped.length) {
      isTapped[index] = !isTapped[index];
      notifyListeners();
    }
  }

  void updateNote(Note note) {
    int ind =
        notes.indexOf(notes.firstWhere((element) => element.id == note.id));
    if (ind != -1) {
      notes[ind] = note;
      sortnotes();
      notifyListeners();
      ApiServices.addNote(note);
    }
  }

  void deleteNote(int index, Note note) {
    if (index >= 0 && index < notes.length) {
      notes.removeAt(index);
      isTapped.removeAt(index);
      sortnotes();
      notifyListeners();
      ApiServices.deleteNote(note);
    }
  }

  void fetchNote() async {
    notes = await ApiServices.fetchNote('prince');
    isTapped = List.filled(notes.length, true, growable: true);
    sortnotes();
    isLaoding = false;
    log(notes.toString());
    notifyListeners();
  }
}
