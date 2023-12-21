import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/PurchaseData.dart';
import '../models/mm.dart';

class prunchprovider extends Notifier<PurchaseDataModule> {
  @override
  PurchaseDataModule build() {
    return PurchaseDataModule(
        fK_Shift_ID: null,
        pkBuyingId: null,
        fkSupplierId: null,
        totalPrice: 0.0,
        date: null,
        billNo: null,
        payment: null,
        fkStoreId: null,
        fkSafeId: null,
        buyMaterialDetails: null);
  }

  void setData({
    int? fK_Shift_ID,
    int? pkBuyingId,
    int? fkSupplierId,
    double? totalPrice,
    String? date,
    String? billNo,
    bool? payment,
    int? fkStoreId,
    int? fkSafeId,
    List<mm>? buyMaterialDetails,
  }) {
    state = state.copyWith(
        fK_Shift_ID: fK_Shift_ID,
        pkBuyingId: pkBuyingId,
        fkSupplierId: fkSupplierId,
        totalPrice: totalPrice,
        billNo: billNo,
        date: date,
        buyMaterialDetails: buyMaterialDetails,
        fkSafeId: fkSafeId,
        fkStoreId: fkStoreId,
        payment: payment);
  }

  void add(double num) {
    print(num);
    final res = (state.totalPrice ?? 0) + num;
    print("object");
    print(res);
    state = state.copyWith(totalPrice: res);
    print(state.totalPrice);
  }
}

final purchasedataProvider =
    NotifierProvider<prunchprovider, PurchaseDataModule>(
  () {
    return prunchprovider();
  },
);
