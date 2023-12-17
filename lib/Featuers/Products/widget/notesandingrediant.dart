import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/Note.dart';
import '../../../providers/noteprovider.dart';
import '../Controller/NoteController.dart';

class Noteandingredient extends ConsumerStatefulWidget {
  const Noteandingredient(
      {super.key,
      required this.search,
      required this.page,
      required this.itemid});
  final bool search;
  final String page;
  final String itemid;

  @override
  ConsumerState<Noteandingredient> createState() => _NoteandingredientState();
}

late List<Note> _text;
late List<Note> _hold;

class _NoteandingredientState extends ConsumerState<Noteandingredient> {
  void getlistfromapi() async {
    print("object");
    _hold = await ref.read(NoteControerProvider).getAll(widget.itemid);
    ref.read(notelistProvider.notifier).addnotelist(_hold);
    // ref.read(notelistProvider.notifier).addnotelist(_hold);

    // print(_text);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.search == true) {
      getlistfromapi();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        _text = ref.watch(notelistProvider);
        return Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(widget.page, arguments: {
                  "id": widget.itemid,
                  "search": widget.search
                }).then((value) {
                  setState(() {});
                });
              },
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
              child: const Text(
                "Add Note",
                style: TextStyle(color: Colors.white),
              ),
            ),
            for (Note i in /*ref.watch(notelistProvider)*/ _text)
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * .42,
                ),
                child: Container(
                    margin: const EdgeInsets.all(2),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14)),
                    child: Text(i.note)),
              )
          ],
        );
      },
    );
  }
}
