import 'dart:io';

import 'package:flutter/material.dart';

void disconnected(Function todo, BuildContext context) async {
  try {
    final result = await InternetAddress.lookup('example.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      todo();
    }
  } on SocketException catch (_) {
    showAdaptiveDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Connection Error"),
          content: Text("You are disconnected"),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"))
          ],
        );
      },
    );
  }
}
