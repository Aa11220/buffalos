import 'package:buffalos/apis/EmpForEndShift/EmpEndShiftAPi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/EmpEndShift.dart';

final EndShiftControllerProvider = Provider<EndShiftController>((ref) {
  final api = ref.watch(EmpEndShiftApiProvider);
  return EndShiftController(empEndShiftApi: api);
});

class EndShiftController {
  final EmpEndShiftApi empEndShiftApi;

  EndShiftController({required this.empEndShiftApi});
  Future<List<EmpEndShift>> getAllCashiers(BuildContext context) async {
    try {
      final list = await empEndShiftApi.getallemp();
      final result =
          list.where((element) => element.job_category == "كاشير").toList();
      return result;
    } catch (e) {
      if (context.mounted) {
        showAdaptiveDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Error happened"),
            );
          },
        );
      }
      return [];
    }
  }
}
