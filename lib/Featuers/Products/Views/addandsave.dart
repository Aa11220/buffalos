import 'package:buffalos/Featuers/Products/widget/notesandingrediant.dart';
import 'package:buffalos/utility/commonwidget/drawer.dart';
import 'package:buffalos/utility/lineargragr.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'dart:io';

import '../../../utility/dummy.dart';

class addandsave extends StatefulWidget {
  const addandsave({super.key});

  @override
  State<addandsave> createState() => _addandsaveState();
}

class _addandsaveState extends State<addandsave> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController Maincategory = TextEditingController();
  TextEditingController subcategory = TextEditingController();
  TextEditingController PerapareAre = TextEditingController();

  SuggestionsBoxController mainbox = SuggestionsBoxController();
  SuggestionsBoxController subbox = SuggestionsBoxController();
  SuggestionsBoxController prebbox = SuggestionsBoxController();

  double spaces = 5;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(gradient: linear),
        child: GestureDetector(
          onTap: () {
            mainbox.close();
            subbox.close();
            prebbox.close();
          },
          child: Scaffold(
            appBar: AppBar(
              title: Text("Products"),
              actions: [Image.asset("assets/img/image005.png")],
            ),
            drawer: MyDrawer(context),
            body: Padding(
              padding: EdgeInsets.all(12),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Item frist language name"),
                      SizedBox(
                        height: spaces,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            hintText: "Enter Item frist language name "),
                      ),
                      SizedBox(
                        height: spaces,
                      ),
                      Text(
                        "Item Second language name",
                      ),
                      SizedBox(
                        height: spaces,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            hintText: "Enter Item Second language name"),
                      ),
                      SizedBox(
                        height: spaces,
                      ),
                      Text(
                        "Main category",
                      ),
                      SizedBox(
                        height: spaces,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .3,
                            child: TypeAheadField<String?>(
                              suggestionsBoxController: mainbox,
                              hideOnEmpty: true,
                              hideSuggestionsOnKeyboardHide: true,
                              suggestionsBoxVerticalOffset: 0,
                              textFieldConfiguration: TextFieldConfiguration(
                                decoration: InputDecoration(
                                    hintText: "Select..",
                                    filled: true,
                                    fillColor: Colors.white,
                                    suffixIcon:
                                        Icon(Icons.keyboard_double_arrow_down)),
                                controller: Maincategory,
                              ),
                              suggestionsBoxDecoration:
                                  SuggestionsBoxDecoration(),
                              suggestionsCallback: ClassName.getsuggest,
                              itemBuilder: (context, String? itemData) {
                                return ListTile(title: Text(itemData!));
                              },
                              onSuggestionSelected: (suggestion) {
                                Maincategory.text = suggestion!;
                                print(suggestion);
                              },
                            ),
                          ),
                          CircleAvatar(
                            backgroundColor: Color(0xFF90391E),
                            child: IconButton(
                              onPressed: () => _showdialolgmain(
                                  context, Maincategory, "Main category"),
                              icon: Icon(Icons.add),
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .3,
                            child: TypeAheadField<String?>(
                              suggestionsBoxController: subbox,
                              hideOnEmpty: true,
                              hideSuggestionsOnKeyboardHide: true,
                              suggestionsBoxVerticalOffset: 0,
                              textFieldConfiguration: TextFieldConfiguration(
                                decoration: InputDecoration(
                                    hintText: "Select..",
                                    filled: true,
                                    fillColor: Colors.white,
                                    suffixIcon:
                                        Icon(Icons.keyboard_double_arrow_down)),
                                controller: subcategory,
                              ),
                              suggestionsBoxDecoration:
                                  SuggestionsBoxDecoration(),
                              suggestionsCallback: ClassName.getsuggest,
                              itemBuilder: (context, String? itemData) {
                                return ListTile(title: Text(itemData!));
                              },
                              onSuggestionSelected: (suggestion) {
                                subcategory.text = suggestion!;
                                print(suggestion);
                              },
                            ),
                          ),
                          CircleAvatar(
                            backgroundColor: Color(0xFF90391E),
                            child: IconButton(
                              onPressed: () {
                                _showdialolgmainsubcategory(context,
                                    subcategory, Maincategory, subcategory);
                              },
                              icon: Icon(Icons.add),
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: spaces,
                      ),
                      Text("Perapare Area"),
                      SizedBox(
                        height: spaces,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .3,
                            child: TypeAheadField<String?>(
                              suggestionsBoxController: prebbox,
                              hideOnEmpty: true,
                              hideSuggestionsOnKeyboardHide: true,
                              suggestionsBoxVerticalOffset: 0,
                              textFieldConfiguration: TextFieldConfiguration(
                                decoration: InputDecoration(
                                    hintText: "Select..",
                                    filled: true,
                                    fillColor: Colors.white,
                                    suffixIcon:
                                        Icon(Icons.keyboard_double_arrow_down)),
                                controller: PerapareAre,
                              ),
                              suggestionsBoxDecoration:
                                  SuggestionsBoxDecoration(),
                              suggestionsCallback: ClassName.getsuggest,
                              itemBuilder: (context, String? itemData) {
                                return ListTile(title: Text(itemData!));
                              },
                              onSuggestionSelected: (suggestion) {
                                PerapareAre.text = suggestion!;
                                print(suggestion);
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 18),
                            child: CircleAvatar(
                              backgroundColor: Color(0xFF90391E),
                              child: IconButton(
                                onPressed: () => _showdialolgmain(
                                    context, PerapareAre, "Perapare Area"),
                                icon: Icon(Icons.add),
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: spaces,
                      ),
                      Text("price"),
                      SizedBox(
                        height: spaces,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.35,
                              child: TextFormField(
                                decoration: InputDecoration(
                                    hintText: "Enter price...."),
                              )),
                          ElevatedButton(
                            onPressed: () {
                              pickfile();
                            },
                            style: ButtonStyle(
                                splashFactory: NoSplash.splashFactory,
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        const Color(0xFFFFFFFF)),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        8.0), // radius you want
                                  ),
                                )),
                            child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Text(
                                    'Attatch File',
                                    style: TextStyle(color: Color(0xFF923D22)),
                                  ),
                                  Icon(
                                    Icons.attachment,
                                    color: Color(0xFF923D22),
                                    size: 24.0,
                                  ),
                                ]),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .01,
                          )
                        ],
                      ),
                      SizedBox(
                        height: spaces,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Noteandingredient(title: "Add Note"),
                          Noteandingredient(title: "Add Ingrediants")
                        ],
                      ),
                      SizedBox(
                        height: spaces,
                      ),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            "Save",
                            style: TextStyle(color: Colors.white),
                          ),
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
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> _showdialolgmain(
    BuildContext context, TextEditingController controller, String titletext) {
  return showAdaptiveDialog(
    context: context,
    builder: (context) {
      return AlertDialog.adaptive(
        title: Text(
          "$titletext",
          style: TextStyle(color: Color(0xFF90391E)),
        ),
        content: TextFormField(
          controller: controller,
          decoration: InputDecoration(hintText: "Enter Main Category"),
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Disable'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Enable'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Future<void> _showdialolgmainsubcategory(
    BuildContext context,
    TextEditingController controller,
    TextEditingController main,
    TextEditingController secondcontroller) {
  return showAdaptiveDialog(
    context: context,
    builder: (context) {
      return AlertDialog.adaptive(
        title: Text(
          "Add sub category",
          style: TextStyle(color: Color(0xFF90391E)),
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("main category"),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * .4,
                child: TypeAheadField<String?>(
                  hideOnEmpty: true,
                  hideSuggestionsOnKeyboardHide: true,
                  suggestionsBoxVerticalOffset: 0,
                  textFieldConfiguration: TextFieldConfiguration(
                    decoration: InputDecoration(
                        hintText: "Select..",
                        filled: true,
                        fillColor: Colors.white,
                        suffixIcon: Icon(Icons.keyboard_double_arrow_down)),
                    controller: main,
                  ),
                  suggestionsBoxDecoration: SuggestionsBoxDecoration(),
                  suggestionsCallback: ClassName.getsuggest,
                  itemBuilder: (context, String? itemData) {
                    return ListTile(title: Text(itemData!));
                  },
                  onSuggestionSelected: (suggestion) {
                    main.text = suggestion!;
                    print(suggestion);
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text("sub category"),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: secondcontroller,
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Disable'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Enable'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

void pickfile() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles();
  if (result != null) {
    File file = File(result.files.single.path!);
    print(file.uri);
  } else {
    // User canceled the picker
  }
}
