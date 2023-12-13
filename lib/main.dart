import 'package:buffalos/Featuers/EndShift/view/End_Shift_Screen.dart';
import 'package:buffalos/Featuers/EndShift/view/Manager_Aproval.dart';

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
      title: 'Flutter Demo',
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
        StockBalance.path: (context) => StockBalance(),
        MangerAproval.path: (context) => MangerAproval(),
        EndShift.endpath: (context) => EndShift(),
        SafeDataScreen.path: (context) => SafeDataScreen(),
        '/test': (context) => const done(),
      },
    );
  }
}
