import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../apis/userapi.dart';
import '../../Products/Views/productspage.dart';

final loginControllerProvider = Provider((ref) {
  final Userapi = ref.watch(authprovider);

  return loginController(Userapi: Userapi);
});

class loginController {
  final userApi Userapi;

  loginController({required this.Userapi});
  Future<void> signincont(
      String username, String password, BuildContext context) async {
    final logedin = await Userapi.signin(username, password);
    logedin.fold(
        (l) => ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(l.message))),
        (r) => Navigator.of(context).popAndPushNamed(productPage.path));
  }
}
