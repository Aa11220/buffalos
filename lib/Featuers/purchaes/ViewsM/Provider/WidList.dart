import 'package:buffalos/Featuers/purchaes/widgets/CustomCard.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class widlistNotifier extends Notifier<List<int>> {
  @override
  build() {
    return [];
    
  }

  void add(int index) {
    state = [...state, index];
  }

  void delete(int index) {
    state.removeAt(index);

    state = [...state];
  }
}

final widlist = NotifierProvider<widlistNotifier, List<int>>(
  () {
    return widlistNotifier();
  },
);
