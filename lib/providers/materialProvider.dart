import '../models/Material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class itemsProvider extends Notifier<List<Material>> {
  @override
  List<Material> build() {
    return [];
  }

  void add(Material maa) {
    state = [...state, maa];
  }

  void delete({
    int? index,
  }) {
    state.removeAt(index!);

    state = [...state];
  }
}

final itemsProvid = NotifierProvider<itemsProvider, List<Material>>(
  () {
    return itemsProvider();
  },
);
