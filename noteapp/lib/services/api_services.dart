import 'dart:convert';
import 'dart:developer';

import 'package:noteapp/models/note.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  static String _baseUrl = "https://notesapp-suda.onrender.com/notes";

  // Replace with your actual base URL

  static Future<void> addNote(Note note) async {
    Uri requestUri = Uri.parse("$_baseUrl/add");

    // Ensure the body is encoded as a JSON string
    var body = jsonEncode(note.toMap());

    // Log the request body for debugging
    log('Request body: $body');

    try {
      var response = await http.post(
        requestUri,
        headers: {
          'Content-Type': 'application/json',
        },
        body: body,
      );

      // Log the response details for debugging
      log('Response status: ${response.statusCode}');
      log('Response body: ${response.body}');

      // Check if the response is successful
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

    // Ensure the body is encoded as a JSON string
    var body = jsonEncode(note.toMap());

    // Log the request body for debugging
    log('Request body: $body');

    try {
      var response = await http.post(
        requestUri,
        headers: {
          'Content-Type': 'application/json',
        },
        body: body,
      );

      // Log the response details for debugging
      log('Response status: ${response.statusCode}');
      log('Response body: ${response.body}');

      // Check if the response is successful
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

    // Encode the request body as a JSON string
    var body = jsonEncode({"userid": userId});

    // Log the request body for debugging
    log('Request body: $body');

    try {
      var response = await http.post(
        requestUri,
        headers: {
          'Content-Type': 'application/json',
        },
        body: body,
      );

      // Log the response details for debugging
      log('Response status: ${response.statusCode}');
      log('Response body: ${response.body}');

      // Check if the response is successful
      if (response.statusCode == 200) {
        var decode = jsonDecode(response.body);
        log('Decoded response: $decode');

        // Map the decoded response to a list of Note objects
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
