import 'package:buffalos/models/mm.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/mmmodule.dart';

class MmProvider extends Notifier<MmModule> {
  @override
  MmModule build() {
    return MmModule(mylist: [], total: 0.0);
  }

  void add({int id = 0}) {
    state.mylist = [
      ...state.mylist,
      mm(
        fkBuyMaterial: 0,
        fkMaterialId: 0,
        pkBuyMaterialId: id,
        price: 0,
        qty: 0,
      )
    ];
  }

  void updateid({
    int? qty,
    int? index,
  }) {
    final main = state.mylist.elementAt(index!);
    final ss = main.copyWith(fkMaterialId: qty);
    state.mylist[index] = ss;

    state = state;
  }

  void updateqty({
    double? qty,
    int? index,
  }) {
    final main = state.mylist.elementAt(index!);
    final ss = main.copyWith(qty: qty);
    state.mylist[index] = ss;

    state = state;
  }

  void updateprice({
    double? price,
    int? index,
  }) {
    final main = state.mylist.elementAt(index!);
    final ss = main.copyWith(price: price);
    state.mylist[index] = ss;

    state = state;
  }

  void calc() {
    var sum = 0.0;
    print(sum);
    for (var i in state.mylist) {
      sum += (i.price ?? 0) * (i.qty ?? 0);
    }

    state = state.copyWith(total: sum);
  }

  void delete(int index) {
    state.mylist.removeAt(index);
    calc();
    state = state.copyWith(mylist: state.mylist);
  }
}

final mmProvider = NotifierProvider<MmProvider, MmModule>(
  () {
    return MmProvider();
  },
);
