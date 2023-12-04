import '../models/ingediants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Cingrediantslist extends Notifier<List<ingrediants>> {
  @override
  build() {
    return [];
  }

  void addnote(ingrediants add) {
    state = [...state, add];
  }

  void addnotelist(List<ingrediants> add) {
    state = [...state, ...add];
  }

  void deletall() {
    state = [];
  }

  void deleteavalue(int value) {
    state = [
      for (final anitem in state)
        if (anitem.FK_MaterialID != value) anitem
    ];
  }

  getall() {
    return state;
  }
}

final ComponantProvider = NotifierProvider<Cingrediantslist, List<ingrediants>>(
  () {
    return Cingrediantslist();
  },
);
