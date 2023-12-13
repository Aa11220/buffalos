import 'package:buffalos/Featuers/report/views/safeBalanceScreen.dart';

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
              Navigator.of(context).pushNamed(StockBalance.path);
            },
            title: Text("StockBalance"),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed(EndShift.endpath);
            },
            title: Text("End Shift"),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed(SafeDataScreen.path);
            },
            title: Text("safe Data"),
          ),
        ],
      ),
    );
  }
}
