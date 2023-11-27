import 'package:flutter/material.dart';

class Noteandingredient extends StatefulWidget {
  const Noteandingredient({super.key, required this.title, required this.page});
  final String title;
  final String page;
  @override
  State<Noteandingredient> createState() => _NoteandingredientState();
}

class _NoteandingredientState extends State<Noteandingredient> {
  final text = [1, 2, 3, 4];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushNamed(widget.page);
          },
          child: Text(
            widget.title,
            style: TextStyle(color: Colors.white),
          ),
          style: ButtonStyle(
            splashFactory: NoSplash.splashFactory,
            backgroundColor:
                MaterialStateProperty.all<Color>(const Color(0xFF90391E)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0), // radius you want
              ),
            ),
          ),
        ),
        for (var i in text) Text(i.toString())
      ],
    );
  }
}
