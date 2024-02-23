import 'package:flutter_riverpod/flutter_riverpod.dart';

final EmpStringNotifierProvider =
    NotifierProvider<EmpStringNotifier, String?>(EmpStringNotifier.new);

class EmpStringNotifier extends Notifier<String?> {
  @override
  String? build() {
    return null;
  }

  void Setvalue(String Value) {
    state = Value;
  }
}
