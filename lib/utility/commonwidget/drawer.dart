import '../../Featuers/EndShiftReport/Views/EndShiftScreen.dart';
import '../../Featuers/Expensses/View/Expenses.dart';
import '../../Featuers/SafeTransfer/View/SafeTransferScree.dart';
import '../../Featuers/Supplier/view/Supplier.dart';
import '../../Featuers/purchaes/Views/PurchaseDataScreen.dart';
import '../../Featuers/purchaes/ViewsM/PurchaseDataScreen.dart';
import '../../Featuers/report/ItemSalesReport/View/ItemSalesReportScreen.dart';
import '../../Featuers/report/MonthlyReport/Views/MonthlyReportScreen.dart';
import '../../Featuers/report/NetProfitInterval/Views/NetProfitIntervelScreen.dart';
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
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(StockBalance.path);
            },
            title: const Text("StockBalance"),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(EndShift.endpath);
            },
            title: const Text("End Shift"),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(SafeDataScreen.path);
            },
            title: const Text("safe Data"),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(MPurchaseDataScreenM.path);
            },
            title: const Text("Purchase Data"),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(EpensesScreen.path);
            },
            title: const Text("Expenses"),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pop();

              Navigator.of(context).pushNamed(SupplierScreen.path);
            },
            title: const Text("Supplier"),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(SafeTransferScreen.path);
            },
            title: const Text("Safe Transfer"),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(EndShiftReportScreen.path);
            },
            title: const Text("End Shift Report"),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(NetProfitIntervelScreen.path);
            },
            title: const Text("NetProfit Interval"),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(ItemsalesReportScreen.path);
            },
            title: const Text("Item sales Report"),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(MonthlyReportScreen.path);
            },
            title: const Text("Monthly Report"),
          ),
        ],
      ),
    );
  }
}
