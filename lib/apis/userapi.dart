import 'dart:convert';
import 'dart:developer';

import '../models/user.dart';
import '../utility/Failuer.dart';
import '../utility/contants.dart';
import '../utility/type_defs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;

final authprovider = ChangeNotifierProvider<userApi>((ref) {
  return userApi();
});

class userApi extends ChangeNotifier {
  bool loading = false;
  user logedin = user(
      token: "",
      userName: "",
      emp_ProfilePic: "",
      fkSafeId: 0,
      pkEmpId: 0,
      shiftID: 0);
  set setName(user name) {
    logedin = name;
    notifyListeners();
  }

  futuerorfaluer<user> signin(String User, String password) async {
    final url = Uri.http(baseUrl, "/Login");
    try {
      print(url);
      final response = await http.post(url,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"username": User, "password": password}));

      final jsonbody = jsonDecode(response.body);

      final statuscode = jsonbody["sts"]["code"];
      if (statuscode == 200) {
        logedin = user.fromMap(jsonbody);
        setName = logedin;

        return right(logedin);
      } else {
        return left(
          Faliuer(
            message: jsonbody["sts"]["msg"],
          ),
        );
      }
    } catch (e, StackTrace) {
      print(e.toString());
      return left(Faliuer(
          message: "Error happened +${e.toString()}", stacktrace: StackTrace));
    }
  }
}
