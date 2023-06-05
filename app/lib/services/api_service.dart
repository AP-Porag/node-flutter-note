import 'dart:convert';
import 'dart:developer';

import 'package:node_flutter_note_app/models/note.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static String _baseUrl = 'http://192.168.1.14:5000/notes';

  static Future<List<Note>> fetchNotes(String userid) async {
    Uri requestUri = Uri.parse(_baseUrl + "/" + userid);
    var response = await http.get(requestUri);
    var decoded = jsonDecode(response.body);
    // log(decoded.toString());
    log(decoded['data'].toString());
    List<Note> notes = [];
    for (var noteMap in decoded['data']) {
      var newNote = Note.fromMap(noteMap);
      notes.add(newNote);
    }
    return notes;
  }

  static Future<void> addNote(Note note) async {
    Uri requestUri = Uri.parse(_baseUrl + "/store");
    var response = await http.post(requestUri, body: note.toMap());
    var decoded = jsonDecode(response.body);
    log(decoded.toString());
  }

  static Future<void> deleteNote(Note note) async {
    print(note.id);
    Uri requestUri = Uri.parse(_baseUrl + "/store");
    // var response = await http.delete(requestUri, body: note.toMap());
    // var decoded = jsonDecode(response.body);
    // log(decoded.toString());
  }
}
