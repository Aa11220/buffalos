// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:buffalos/apis/SafeData/SafeDataApi.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/SafeData.dart';

final SafeControllerProvider = Provider<safecontrol>((ref) {
  final api = ref.watch(SafeDataApiProvider);
  return safecontrol(api: api);
});

class safecontrol {
  final SafeDataApi api;
  safecontrol({
    required this.api,
  });
  Future<List<SafeData>> getall() async {
    final list = await api.getsafeData();
    log(list.toString());
    return list;
  }
}
