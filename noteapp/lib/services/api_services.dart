import 'dart:convert';
import 'dart:developer';

import 'package:noteapp/models/note.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  static String _baseUrl = "https://notesapp-suda.onrender.com/notes";

  static Future<void> addNote(Note note) async {
    Uri requestUri = Uri.parse(_baseUrl + "/add");
    var respone = await http.post(requestUri, body: note.toMap());
    var decode = jsonDecode(respone.body);
    log(decode.toString());
  }

  static Future<void> deleteNote(Note note) async {
    Uri requestUri = Uri.parse(_baseUrl + "/delete");
    var respone = await http.post(requestUri, body: note.toMap());
    var decode = jsonDecode(respone.body);
    log(decode.toString());
  }

  static Future<List<Note>> fetchNote(String userId) async {
    Uri requestUri = Uri.parse(_baseUrl + "/list");
    var respone = await http.post(requestUri, body: {"userid": userId});
    var decode = jsonDecode(respone.body);
    log(decode.toString());
    return [];
  }
}
