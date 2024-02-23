import '../models/EmpDataModule.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final EmpEndShiftProvider =
    AutoDisposeNotifierProvider<EmpshiftdataNotifier, EmpData?>(
        EmpshiftdataNotifier.new);

class EmpshiftdataNotifier extends AutoDisposeNotifier<EmpData?> {
  @override
  build() {
    return null;
  }

  void update(EmpData vlaue) {
    state = vlaue;
  }
}
