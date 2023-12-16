import 'dart:convert';
import 'dart:developer';

import '../userapi.dart';
import '../../models/Email/Email.dart';
import '../../utility/contants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final EmailToApiProvider = Provider<EmailToApi>((ref) {
  final token = ref.watch(authprovider).logedin.token;
  return EmailToApi(tooken: token);
});

class EmailToApi {
  final String tooken;

  EmailToApi({required this.tooken});
  Future<List<Email>> getEmails() async {
    List<Email> list = [];
    final url = Uri.http(baseUrl, "/Email/GetEmailsTo");
    final response = await http.get(
      url,
      headers: {"Accept": "text/plain", 'Authorization': 'Bearer $tooken'},
    );
    log(response.statusCode.toString());
    log(response.body);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      for (var element in data) {
        list.add(Email.fromMap(element));
      }
      return list;
    } else {
      throw Exception('Failed to load email');
    }
  }
}
