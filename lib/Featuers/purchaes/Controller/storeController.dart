import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../apis/shopsapi.dart';
import '../../../models/Stores.dart';

final storeControllerProvider = Provider<storeController>((ref) {
  final api = ref.read(StoressApiProvider);
  return storeController(api: api);
});

class storeController {
  final StoressApi api;
  storeController({required this.api});

  Future<List<Stores>> getall(BuildContext context) async {
    try {
      final list = await api.getStores();
      list.removeAt(0);
      return list;
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Some thing went wrong")));
      }

      rethrow;
    }
  }
}
