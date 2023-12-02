import 'package:flutter/material.dart';

class Customappbar extends StatelessWidget implements PreferredSizeWidget {
  final String text;

  const Customappbar({super.key, required this.text});
  @override
  Widget build(BuildContext context) {
    return AppBar(title: Text(text), actions: [
      Image.asset("assets/img/image005.png"),
    ]);
  }

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}
