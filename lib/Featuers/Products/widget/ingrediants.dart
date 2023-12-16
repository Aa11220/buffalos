import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/ingediants.dart';
import '../../../providers/igrediantsprovider.dart';
import '../Controller/ingredControllrt.dart';
import '../Views/addingred.dart';

class igrediants extends ConsumerStatefulWidget {
  const igrediants(
      {super.key,
      required this.search,
      required this.page,
      required this.itemid,
      required this.itemname});
  final bool search;
  final String page;
  final String itemid;
  final String itemname;

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
    if (widget.search == true) {
      setlist();
    }
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Consumer(
      builder: (context, ref, child) {
        final alllist = ref.watch(ingredianlistProvider);
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pushNamed(addIngredient.path, arguments: {
                  "id": widget.itemid,
                  "name": widget.itemname,
                  "search": widget.search
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
                "Add ingrediant",
                style: TextStyle(color: Colors.white),
              ),
            ),
            for (ingrediants i in alllist)
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * .5,
                ),
                child: Container(
                    margin: const EdgeInsets.all(2),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14)),
                    child: Text(
                      i.MaterialName,
                    )),
              )
          ],
        );
      },
    );
  }
}
