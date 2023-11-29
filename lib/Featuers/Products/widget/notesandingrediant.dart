import 'package:buffalos/Featuers/Products/Controller/NoteController.dart';

import 'package:buffalos/models/Note.dart';
import 'package:buffalos/providers/noteprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Noteandingredient extends ConsumerStatefulWidget {
  const Noteandingredient(
      {super.key,
      required this.title,
      required this.page,
      required this.itemid});
  final String title;
  final String page;
  final String itemid;

  @override
  ConsumerState<Noteandingredient> createState() => _NoteandingredientState();
}

late List<Note> _text;
late List<Note> _hold;

class _NoteandingredientState extends ConsumerState<Noteandingredient> {
  @override
  void getlistfromapi() async {
    print("object");
    _hold = await ref.read(NoteControerProvider).getAll(widget.itemid);
    ref.read(notelistProvider.notifier).addnotelist(_hold);
    // ref.read(notelistProvider.notifier).addnotelist(_hold);
    // _text = ref.read(notelistProvider.notifier).getall();
    // print(_text);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getlistfromapi();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        _text = ref.watch(notelistProvider.notifier).getall();
        ref.watch(notelistProvider);
        return Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(widget.page, arguments: widget.itemid);
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
                    borderRadius:
                        BorderRadius.circular(10.0), // radius you want
                  ),
                ),
              ),
            ),
            for (Note i in /* ref.watch(notelistProvider) */ _text)
              Container(
                  margin: EdgeInsets.all(2),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14)),
                  child: Text(i.note))
          ],
        );
      },
    );
  }
}
