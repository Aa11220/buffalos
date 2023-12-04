import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/maaterialtosend.dart';

class ingredianttosendslist extends Notifier<List<materialtosend>> {
  @override
  build() {
    return [];
  }

  void addnote(materialtosend add) {
    state = [...state, add];
  }

  void addnotelist(List<materialtosend> add) {
    state = [...state, ...add];
  }

  void deletall() {
    state = [];
  }

  void deleteavalue(int value) {
    state = [
      for (final anitem in state)
        if (anitem.fkComponent != value) anitem
    ];
  }

  getall() {
    return state;
  }
}

final ingrediantosendlistProvider =
    NotifierProvider<ingredianttosendslist, List<materialtosend>>(
  () {
    return ingredianttosendslist();
  },
);
