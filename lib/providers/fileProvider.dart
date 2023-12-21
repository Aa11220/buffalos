import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class fileNotifier extends Notifier<File?> {
  @override
  build() {
    return null;
  }

  void setfile(File myfile) {
    state = myfile;
  }

  void removefile() {
    state = null;
  }

  File send() {
    return state!;
  }
}

final filenotifierProvider = NotifierProvider<fileNotifier, File?>(() {
  return fileNotifier();
});
