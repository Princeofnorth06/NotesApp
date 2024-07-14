import 'package:flutter/material.dart';
import 'package:noteapp/models/note.dart';
import 'package:noteapp/services/api_services.dart';

class NoteProvider with ChangeNotifier {
  List<Note> notes = [];
  List<bool> isTapped = [];
  NoteProvider() {
    fetchNote();
  }

  void addNote(Note note) {
    notes.add(note);
    isTapped.add(true);
    notifyListeners();
    ApiServices.addNote(note);
  }

  void toggleTapped(int index) {
    isTapped[index] = !isTapped[index];
    notifyListeners();
  }

  void updateNote(Note note) {
    int ind =
        notes.indexOf(notes.firstWhere((element) => element.id == note.id));
    notes[ind] = note;
    notifyListeners();
    ApiServices.addNote(note);
  }

  void deleteNote(int index, Note note) {
    notes.removeAt(index);
    notifyListeners();
    ApiServices.deleteNote(note);
  }

  void fetchNote() async {
    List<Note> fetchNote = await ApiServices.fetchNote('prince');
  }
}
