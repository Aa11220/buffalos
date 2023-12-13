import 'dart:io';
import 'userapi.dart';
import '../utility/contants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart ' as http;

final fileProvider = Provider<FileApi>((ref) {
  final token = ref.watch(authprovider).logedin.token;

  return FileApi(tokken: token);
});

class FileApi {
  final String tokken;

  FileApi({required this.tokken});
  Future<void> addfile(File file, String itemid) async {
    final url =
        Uri.http(baseUrl, "/FileUpload/UploadItemImages", {"Item_ID": itemid});
    final request = http.MultipartRequest("POST", url);
    request.headers.addAll(
      {
        "Content-Type": "multipart/form-data",
        'Authorization': 'Bearer $tokken'
      },
    );
    final multiport = await http.MultipartFile.fromPath("file", file.path);
    request.files.add(multiport);
    var response = await request.send();
    print(response.statusCode);
  }
}
