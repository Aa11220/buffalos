import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../apis/EmpData/EmpDataApi.dart';
import '../../../models/EmpDataModule.dart';

final EmpDataControllerProvider = Provider<EmpDataController>((ref) {
  final api = ref.watch(EmpDataApiProvider);
  return EmpDataController(api: api);
});

class EmpDataController {
  final EmpDataApi api;

  EmpDataController({required this.api});
  Future<EmpData> getdata(String Shift) async {
    final data = await api.Getdata(Shift);
    return data;
  }
}
