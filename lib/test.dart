import 'package:buffalos/apis/userapi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class done extends ConsumerWidget {
  const done({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(authprovider).logedin.token;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Text(state),
          // child: Consumer(builder: (context, WidgetRef ref, child) {
          //   final token = ref.watch(authprovider).logedin.token;
          //   return Text(token);
          // }),
        ));
  }
}
