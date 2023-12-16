import "dart:convert";

import "../../utility/contants.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:http/http.dart" as http;

import "../userapi.dart";

final EndShittoApiProvider = Provider<EndShittoApi>((ref) {
  final token = ref.watch(authprovider).logedin.token;

  return EndShittoApi(tokken: token);
});

class EndShittoApi {
  final String tokken;

  EndShittoApi({required this.tokken});
  Future<void> ChangeShift(int idend, int idstart) async {
    final url = Uri.http(baseUrl, "/Admin/EndShift");
    var response = await http.post(url,
        headers: {
          "Authorization": "Bearer $tokken",
          "Content-Type": "application/json"
        },
        body: jsonEncode({"empID": "$idend", "empToID": "$idstart"}));
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      print("Success!");
    }
  }
}
