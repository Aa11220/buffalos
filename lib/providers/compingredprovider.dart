import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/ingediants.dart';

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
    state.removeAt(value);
    state = [...state];
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
