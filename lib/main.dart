import 'Featuers/EndShiftReport/Views/EndShiftScreen.dart';
import 'Featuers/Expensses/View/Expenses.dart';
import 'Featuers/purchaes/ViewsM/AddRawMaterialScreen.dart';

import 'Featuers/EndShift/view/End_Shift_Screen.dart';
import 'Featuers/EndShift/view/Manager_Aproval.dart';

import 'Featuers/SafeTransfer/View/SafeTransferScree.dart';
import 'Featuers/Supplier/view/Supplier.dart';
import 'Featuers/purchaes/Views/AddRawMaterialScreen.dart';
import 'Featuers/purchaes/Views/PurchaseDataScreen.dart';
import 'Featuers/purchaes/ViewsM/PurchaseDataScreen.dart';
import 'Featuers/report/ItemSalesReport/View/ItemSalesReportScreen.dart';
import 'Featuers/report/MonthlyReport/Views/MonthlyReportScreen.dart';
import 'Featuers/report/NetProfitInterval/Views/NetProfitIntervelScreen.dart';
import 'Featuers/report/views/StockBalanceview.dart';

import 'Featuers/Products/Views/addnote.dart';
import 'Featuers/Products/Views/productspage.dart';
import 'Featuers/login/views/loginPage.dart';
import 'Featuers/report/views/safeBalanceScreen.dart';
import 'test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'Featuers/Products/Views/addandsave.dart';
import 'Featuers/Products/Views/addingred.dart';

void main() {
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chinkin',
      theme: ThemeData(
        inputDecorationTheme:
            const InputDecorationTheme(filled: true, fillColor: Colors.white),
        appBarTheme: const AppBarTheme(
            foregroundColor: Color(0xFF90391E),
            backgroundColor: Color(0xFFF2E2E1)),
        scaffoldBackgroundColor: Colors.transparent,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFF78823)),
        useMaterial3: true,
      ),
      home: const loginPage(),
      routes: {
        addIngredient.path: (context) => const addIngredient(),
        addnote.path: (context) => const addnote(),
        productPage.path: (context) => const productPage(),
        addandsave.path: (context) => const addandsave(),
        StockBalance.path: (context) => const StockBalance(),
        MangerAproval.path: (context) => const MangerAproval(),
        EndShift.endpath: (context) => const EndShift(),
        SafeDataScreen.path: (context) => const SafeDataScreen(),
        PurchaseDataScreen.path: (context) => const PurchaseDataScreen(),
        AddRawMaterialScreen.path: (context) => const AddRawMaterialScreen(),
        EpensesScreen.path: (context) => const EpensesScreen(),
        SupplierScreen.path: (context) => const SupplierScreen(),
        SafeTransferScreen.path: (context) => const SafeTransferScreen(),
        '/test': (context) => const done(),
        MAddMaterialM.path: (context) => MAddMaterialM(),
        MPurchaseDataScreenM.path: (context) => MPurchaseDataScreenM(),
        EndShiftReportScreen.path: (context) => EndShiftReportScreen(),
        NetProfitIntervelScreen.path: (context) => NetProfitIntervelScreen(),
        ItemsalesReportScreen.path: (context) => ItemsalesReportScreen(),
        MonthlyReportScreen.path: (context) => MonthlyReportScreen()
      },
    );
  }
}
