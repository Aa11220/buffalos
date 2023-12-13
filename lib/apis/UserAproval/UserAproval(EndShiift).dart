import 'package:buffalos/apis/userapi.dart';
import 'package:buffalos/models/UserApproval.dart';
import 'package:buffalos/utility/contants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final UserApprovalProvider = Provider<UserApprovalApi>((ref) {
  final token = ref.watch(authprovider).logedin.token;

  return UserApprovalApi(tokken: token);
});

class UserApprovalApi {
  final String tokken;

  UserApprovalApi({required this.tokken});
  Future<UserApprovalResponse> CheckApproval(
      String User, String Password) async {
    final url = Uri.http(baseUrl, "/Admin/ManagerApproval");
    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "text/plain",
          'Authorization': 'Bearer $tokken'
        },
        body: jsonEncode({"userName": User, "password": Password}));
    print(response.statusCode);
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return result;
    } else {
      throw Exception("Not approved");
    }
  }
}
