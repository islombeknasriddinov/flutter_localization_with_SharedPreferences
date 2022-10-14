
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_localization/model/note_model.dart';

class RTDBService{
    static final _database = FirebaseDatabase.instance.reference();

    static Future<Stream<DatabaseEvent>> storeNote(Note note) async{
      _database.child("notes").push().set(note.toJson());
      return _database.onChildAdded;
    }

    static Future<List<Note>> loadNotes(String id) async{
      List<Note>? items= [];
      Query query = _database.child("notes").orderByChild("userId").equalTo(id);
      DatabaseEvent response = await query.once();
      items = response.snapshot.children.map((json) => Note.fromJson(Map<String, dynamic>.from(json.value as Map))).toList();
      return items;
    }
}