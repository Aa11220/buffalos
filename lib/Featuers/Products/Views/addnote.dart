import 'package:buffalos/utility/commonwidget/appbar.dart';
import 'package:buffalos/utility/commonwidget/drawer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../utility/lineargragr.dart';

class addnote extends StatefulWidget {
  const addnote({super.key});

  @override
  State<addnote> createState() => _addnoteState();
}

class _addnoteState extends State<addnote> {
  TextEditingController note = TextEditingController();
  @override
  void dispose() {
    note.dispose();
    super.dispose();
  }

  List rest = ["wet", "ret", "bet"];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          gradient: linear,
        ),
        child: Scaffold(
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
                    icon: Icon(Icons.arrow_back_ios)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .8,
                      child: TextField(
                        controller: note,
                        decoration: InputDecoration(
                          hintText: "Note",
                        ),
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: Color(0xFF90391E),
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            rest.add(note.text);
                          });
                        },
                        icon: Icon(Icons.add),
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.66,
                  child: ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.only(
                        left: (MediaQuery.of(context).size.width * 0.1),
                        right: (MediaQuery.of(context).size.width * 0.1)),
                    itemBuilder: (context, index) {
                      return LayoutBuilder(
                        builder: (context, constraints) {
                          return Container(
                            padding: const EdgeInsets.all(12.0),
                            margin: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.white),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: constraints.maxWidth * .7,
                                  child: Text(rest[index]),
                                ),
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        rest.removeAt(index);
                                      });
                                    },
                                    icon: Icon(Icons.delete))
                              ],
                            ),
                          );
                        },
                      );
                    },
                    itemCount: rest.length,
                  ),
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Back",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ButtonStyle(
                      splashFactory: NoSplash.splashFactory,
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xFF90391E)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(10.0), // radius you want
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
