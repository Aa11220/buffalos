import 'package:flutter/material.dart';

class Customappbar extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  bool image;
  Customappbar({super.key, required this.text, this.image = true});
  @override
  Widget build(BuildContext context) {
    return AppBar(title: Text(text), actions: [
      if (image) Image.asset("assets/img/image005.png"),
    ]);
  }

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}
