import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../apis/shopsapi.dart';
import '../../../models/Stores.dart';

final StoressControllerProvider = Provider<StoressController>((ref) {
  final api = ref.read(StoressApiProvider);
  return StoressController(api: api);
});

class StoressController {
  final StoressApi api;
  StoressController({required this.api});

  Future<List<Stores>> getall(BuildContext context) {
    try {
      final list = api.getStores();
      return list;
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Some thing went wrong")));
      rethrow;
    }
  }
}
