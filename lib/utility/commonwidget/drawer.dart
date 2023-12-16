import '../../Featuers/purchaes/Views/PurchaseDataScreen.dart';
import '../../Featuers/report/views/safeBalanceScreen.dart';

import '../../Featuers/EndShift/view/End_Shift_Screen.dart';
import '../../Featuers/report/views/StockBalanceview.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer(BuildContext context, {super.key});
  @override
  Widget build(context) {
    return Drawer(
      child: Column(
        children: [
          ListTile(
            onTap: () {
              Navigator.of(context).pushReplacementNamed(StockBalance.path);
            },
            title: const Text("StockBalance"),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushReplacementNamed(EndShift.endpath);
            },
            title: const Text("End Shift"),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushReplacementNamed(SafeDataScreen.path);
            },
            title: const Text("safe Data"),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(PurchaseDataScreen.path);
            },
            title: const Text("Purchase Data"),
          ),
        ],
      ),
    );
  }
}
