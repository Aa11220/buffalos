import 'package:buffalos/models/Note.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

  getall() {
    return [...state];
  }
}

final notelistProvider = NotifierProvider<notelistNotifier, List<Note>>(
  () {
    return notelistNotifier();
  },
);
