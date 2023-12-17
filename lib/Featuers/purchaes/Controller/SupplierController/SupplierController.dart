import 'package:buffalos/apis/Supplier/SupplierApi.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../models/Supplier/SupplierModule.dart';

final SupplierControllerProvider = Provider<SupplierController>((ref) {
  final api = ref.read(SupplierApiProvider);
  return SupplierController(api: api);
});

class SupplierController {
  final SupplierApi api;

  SupplierController({required this.api});
  Future<List<SupllierModule>> getall() {
    final list = api.getSuppliers();
    return list;
  }
}
