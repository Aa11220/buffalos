import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/Note.dart';

class notelistNotifier extends Notifier<List<Note>> {
  @override
  build() {
    return [];
  }

  void addnote(Note add) {
    state.add(add);
  }

  void addnotelist(List<Note> add) {
    state.addAll(add);
  }

  void deletall() {
    state = [];
  }

  void deleteavalue(int value) {
    state.removeWhere((element) => element.id == value);
  }

  getall() {
    return state;
  }
}

final notelistProvider = NotifierProvider<notelistNotifier, List<Note>>(
  () {
    return notelistNotifier();
  },
);
