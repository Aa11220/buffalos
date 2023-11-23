import 'package:buffalos/Featuers/Products/Views/addnote.dart';
import 'package:buffalos/Featuers/Products/Views/productspage.dart';
import 'package:buffalos/Featuers/login/views/loginPage.dart';
import 'package:buffalos/test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'Featuers/Products/Views/addandsave.dart';
import 'Featuers/Products/Views/addingred.dart';

void main() {
  runApp(ProviderScope(
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
            InputDecorationTheme(filled: true, fillColor: Colors.white),
        appBarTheme: const AppBarTheme(
            foregroundColor: Color(0xFF90391E),
            backgroundColor: Color(0xFFF2E2E1)),
        scaffoldBackgroundColor: Colors.transparent,
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFFF78823)),
        useMaterial3: true,
      ),
      home: addIngredient(),
      routes: {
        '/test': (context) => const done(),
      },
    );
  }
}
