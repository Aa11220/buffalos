import 'dart:convert';

import 'package:buffalos/apis/userapi.dart';
import 'package:buffalos/models/Note.dart';
import 'package:buffalos/utility/contants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final NoteApiProvider = Provider((ref) {
  final String tokken = ref.watch(authprovider).logedin.token;
  return NoteApi(tokken: tokken);
});

class NoteApi {
  final String tokken;

  NoteApi({required this.tokken});
  Future<List<Note>> getNotes(String iteamid) async {
    List<Note> notelist = [];
    final url = Uri.http(baseUrl, "/TblItemNote/getPage",
        {"pageSize": "2000", "userQuery": "fkItemId=$iteamid"});
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $tokken'
        },
      );
      final body = jsonDecode(response.body);
      final list = body["rs"]["data"];

      for (var element in list) {
        notelist.add(Note.fromMap(element));
      }

      return notelist;
    } catch (e) {
      return [];
    }
  }

  Future<int> addNote(String name, String itemid) async {
    final url = Uri.http(baseUrl, "/TblItemNote/save");
    try {
      final response = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
            "Accept": "text/plain",
            'Authorization': 'Bearer $tokken'
          },
          body: jsonEncode({"note": "$name", "fkItemId": "$itemid"}));
      final responsejson = jsonDecode(response.body);
      print(responsejson);
      final id = responsejson["rs"]["id"];
      return id;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deletenote(String noteid) async {
    final url =
        Uri.http(baseUrl, "/TblItemNote/delete", {"userQuery": "id=$noteid"});
    try {
      final response = await http.delete(url,
          headers: {"Accept": "text/plain", 'Authorization': 'Bearer $tokken'});
      print(response.body);
    } catch (e) {
      rethrow;
    }
  }
}
