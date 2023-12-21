import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/SafeTransferModule.dart';

class SafeTransferNotifier extends Notifier<SafeTransfer> {
  @override
  build() {
    return SafeTransfer(
        fkEmpFrom: 0,
        fkSafeFrom: 0,
        fkSafeTo: 0,
        payNo: "",
        transDate: "",
        value: 0,
        notes: "");
  }

  void getvalue(
      {int? fkEmpFrom,
      int? fkSafeFrom,
      int? fkSafeTo,
      String? notes,
      String? payNo,
      String? transDate,
      double? value}) {
    state = state.copyWith(
      fkEmpFrom: fkEmpFrom,
      fkSafeFrom: fkSafeFrom,
      fkSafeTo: fkSafeTo,
      notes: notes,
      payNo: payNo,
      transDate: transDate,
      value: value,
    );
  }

  getall() {
    return state;
  }
}

final SafeTransferProvider =
    NotifierProvider<SafeTransferNotifier, SafeTransfer>(
  () {
    return SafeTransferNotifier();
  },
);
