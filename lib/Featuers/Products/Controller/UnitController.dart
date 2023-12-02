import 'package:buffalos/apis/Unitapi.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/unit.dart';

final UnitControllerProvider = Provider<UnitController>((ref) {
  final unitapi = ref.watch(UnitapiProvider);
  return UnitController(unitapi: unitapi);
});

class UnitController {
  final Unitapi unitapi;

  UnitController({required this.unitapi});
  Future<List<Unit>> getall() async {
    final list = await unitapi.getUnits();
    print(list);
    return list;
  }
}
