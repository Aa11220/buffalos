import 'package:buffalos/Featuers/Products/Views/addnote.dart';
import 'package:buffalos/apis/Notesapi.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/Note.dart';

final NoteControerProvider = Provider((ref) {
  final NoteApi = ref.watch(NoteApiProvider);
  return NoteController(noteapi: NoteApi);
});

class NoteController {
  final NoteApi noteapi;

  NoteController({required this.noteapi});
  Future<List<Note>> getAll(String iteamid) async {
    if (iteamid.isEmpty) {
      return [];
    } else {
      List<Note> notes = await noteapi.getNotes(iteamid);
      return notes;
    }
  }

  Future<int> addnote(String name, String itemid) async {
    final id = await noteapi.addNote(name, itemid);
    return id;
  }

  Future<void> deletenote(String noteid) async {
    print(noteid);
    await noteapi.deletenote(noteid);
  }
}
