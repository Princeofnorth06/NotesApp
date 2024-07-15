import 'dart:convert';
import 'dart:developer';

import 'package:noteapp/models/note.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  static String _baseUrl = "https://notesapp-suda.onrender.com/notes";

  static Future<void> addNote(Note note) async {
    Uri requestUri = Uri.parse("$_baseUrl/add");

    var body = jsonEncode(note.toMap());

    log('Request body: $body');

    try {
      var response = await http.post(
        requestUri,
        headers: {
          'Content-Type': 'application/json',
        },
        body: body,
      );

      log('Response status: ${response.statusCode}');
      log('Response body: ${response.body}');

      if (response.statusCode == 200) {
        var decode = jsonDecode(response.body);
        log('Decoded response: $decode');
      } else {
        log('Error: ${response.statusCode} - ${response.reasonPhrase}');
      }
    } catch (e) {
      log('Exception caught: $e');
    }
  }

  static Future<void> deleteNote(Note note) async {
    Uri requestUri = Uri.parse("$_baseUrl/delete");

    var body = jsonEncode(note.toMap());

    log('Request body: $body');

    try {
      var response = await http.post(
        requestUri,
        headers: {
          'Content-Type': 'application/json',
        },
        body: body,
      );

      log('Response status: ${response.statusCode}');
      log('Response body: ${response.body}');

      if (response.statusCode == 200) {
        var decode = jsonDecode(response.body);
        log('Decoded response: $decode');
      } else {
        log('Error: ${response.statusCode} - ${response.reasonPhrase}');
      }
    } catch (e) {
      log('Exception caught: $e');
    }
  }

  static Future<List<Note>> fetchNote(String userId) async {
    Uri requestUri = Uri.parse("$_baseUrl/list");

    var body = jsonEncode({"userid": userId});

    log('Request body: $body');

    try {
      var response = await http.post(
        requestUri,
        headers: {
          'Content-Type': 'application/json',
        },
        body: body,
      );

      log('Response status: ${response.statusCode}');
      log('Response body: ${response.body}');

      if (response.statusCode == 200) {
        var decode = jsonDecode(response.body);
        log('Decoded response: $decode');

        List<Note> notes = [];
        for (var noteMap in decode) {
          Note newNote = Note.fromMap(noteMap);
          log(newNote.toString());
          notes.add(newNote);
        }

        return notes;
      } else {
        log('Error: ${response.statusCode} - ${response.reasonPhrase}');
        return [];
      }
    } catch (e) {
      log('Exception caught: $e');
      return [];
    }
  }
}
