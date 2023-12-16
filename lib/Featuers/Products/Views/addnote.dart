import 'dart:math';

import '../../../models/Note.dart';
import '../../../providers/noteprovider.dart';
import '../../../utility/commonwidget/appbar.dart';
import '../../../utility/commonwidget/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utility/lineargragr.dart';

class addnote extends ConsumerStatefulWidget {
  const addnote({
    super.key,
  });

  static const path = "/addnote";

  @override
  ConsumerState<addnote> createState() => _addnoteState();
}

class _addnoteState extends ConsumerState<addnote> {
  var intid;
  TextEditingController note = TextEditingController();
  @override
  void dispose() {
    note.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final item = ModalRoute.of(context)!.settings.arguments as Map;

    if (item["search"]) {
      intid = int.tryParse(item["id"]);
    } else {
      intid = null;
    }
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          gradient: linear,
        ),
        child: Consumer(
          builder: (context, ref, child) {
            return Scaffold(
                drawer: MyDrawer(context),
                appBar: Customappbar(text: "Notes"),
                body: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(Icons.arrow_back_ios)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .8,
                            child: TextField(
                              controller: note,
                              decoration: const InputDecoration(
                                hintText: "Note",
                              ),
                            ),
                          ),
                          CircleAvatar(
                            backgroundColor: const Color(0xFF90391E),
                            child: IconButton(
                              onPressed: () {
                                ref.read(notelistProvider.notifier).addnote(
                                    Note(
                                        id: Random().nextInt(2000),
                                        fkItemId: intid,
                                        note: note.text.isEmpty
                                            ? ""
                                            : note.text));

                                note.text = "";
                                setState(() {});
                              },
                              icon: const Icon(Icons.add),
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Consumer(
                        builder: (context, ref, child) {
                          return SizedBox(
                            height: MediaQuery.of(context).size.height * 0.66,
                            child: ListView.builder(
                                shrinkWrap: true,
                                padding: EdgeInsets.only(
                                    left: (MediaQuery.of(context).size.width *
                                        0.1),
                                    right: (MediaQuery.of(context).size.width *
                                        0.1)),
                                itemBuilder: (context, index) {
                                  return LayoutBuilder(
                                    builder: (context, constraints) {
                                      return Container(
                                        padding: const EdgeInsets.all(12.0),
                                        margin: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            color: Colors.white),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: constraints.maxWidth * .7,
                                              child: Text(ref
                                                  .watch(
                                                      notelistProvider)[index]
                                                  .note),
                                            ),
                                            IconButton(
                                                onPressed: () {
                                                  ref
                                                      .read(notelistProvider
                                                          .notifier)
                                                      .deleteavalue(ref
                                                          .read(notelistProvider)[
                                                              index]
                                                          .id);
                                                  setState(() {});
                                                },
                                                icon: const Icon(Icons.delete))
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                                itemCount: ref.watch(notelistProvider).length),
                          );
                        },
                      ),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          style: ButtonStyle(
                            splashFactory: NoSplash.splashFactory,
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color(0xFF90391E)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    10.0), // radius you want
                              ),
                            ),
                          ),
                          child: const Text(
                            "Back",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                ));
          },
        ),
      ),
    );
  }
}
