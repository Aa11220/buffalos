import 'package:buffalos/Featuers/Products/Controller/ingredControllrt.dart';
import 'package:buffalos/Featuers/Products/Views/addingred.dart';
import 'package:buffalos/models/ingediants.dart';
import 'package:buffalos/providers/igrediantsprovider.dart';

import '../../../models/Note.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class igrediants extends ConsumerStatefulWidget {
  const igrediants(
      {super.key,
      required this.title,
      required this.page,
      required this.itemid});
  final String title;
  final String page;
  final String itemid;

  @override
  ConsumerState<igrediants> createState() => _NoteandingredientState();
}

late List<ingrediants> mylist;

class _NoteandingredientState extends ConsumerState<igrediants> {
  void setlist() async {
    mylist = await ref.read(ingrediantcontrollerprovider).getall(widget.itemid);
    ref.read(ingredianlistProvider.notifier).addnotelist(mylist);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setlist();
  }

  @override
  Widget build(BuildContext context,) {
    return Consumer(
      builder: (context, ref, child) {
        final alllist = ref.watch(ingredianlistProvider);
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context)
                    .pushNamed(addIngredient.path, arguments: widget.itemid);
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
              child: Text(
                widget.title,
                style: const TextStyle(color: Colors.white),
              ),
            ),
            for (ingrediants i in alllist)
              Container(
                  margin: const EdgeInsets.all(2),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14)),
                  child: Text(i.MaterialName))
          ],
        );
      },
    );
  }
}
