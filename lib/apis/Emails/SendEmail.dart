import 'dart:io';

import '../userapi.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../models/Email/Email.dart';
import '../../utility/contants.dart';

final SendEmailApiProvider = Provider<SendEmailApi>((ref) {
  final token = ref.watch(authprovider).logedin.token;
  return SendEmailApi(tokken: token);
});

class SendEmailApi {
  final String tokken;

  SendEmailApi({required this.tokken});
  Future<void> addfile(File file, String subject, List<Email> emails) async {
    final url = Uri.http(
      baseUrl,
      "/Email/SendEmail",
    );
    final request = http.MultipartRequest("POST", url);
    request.headers.addAll(
      {
        "Content-Type": "multipart/form-data",
        'Authorization': 'Bearer $tokken'
      },
    );
    final multiport = await http.MultipartFile.fromPath("file", file.path);
    request.files.add(multiport);
    request.fields["Subject"] = subject;
    for (var i = 0; i < emails.length; i++) {
      request.fields["emailToRequest.mailToRpt[$i].MailTo"] =
          emails.elementAt(i).MailTo;
    }
    var response = await request.send();
    print(response.statusCode);
  }
}
