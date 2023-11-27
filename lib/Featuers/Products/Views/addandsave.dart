import 'package:buffalos/Featuers/Products/Controller/kitchencontroller.dart';
import 'package:buffalos/Featuers/Products/widget/notesandingrediant.dart';
import 'package:buffalos/apis/kitchensapi.dart';
import 'package:buffalos/models/item.dart';
import 'package:buffalos/models/kitchen.dart';
import 'package:buffalos/utility/commonwidget/drawer.dart';
import 'package:buffalos/utility/lineargragr.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'dart:io';

import 'addnote.dart';
import 'addingred.dart';
import '../../../utility/dummy.dart';

class addandsave extends ConsumerStatefulWidget {
  const addandsave({super.key});
  static const path = "addandsaveproducts";
  @override
  ConsumerState<addandsave> createState() => _addandsaveState();
}

class _addandsaveState extends ConsumerState<addandsave> {
  late final arrg;
  late final itemdata;
  String? link;
  bool frist = true;
  void onsave() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    }
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies

    if (frist) {
      arrg = ModalRoute.of(context)!.settings.arguments as Map;

      if (arrg['Search']) {
        itemdata = arrg["item"] as Map;
        fristname = TextEditingController(text: itemdata!["itemName"]);
        secondname = TextEditingController(text: itemdata!["itemNameLang2"]);
        link = itemdata!["itemImage"];
        Maincategory = TextEditingController();
        subcategory = TextEditingController();
        PerapareAre =
            TextEditingController(text: itemdata!["fkPrepareId"].toString());
        price = TextEditingController(text: itemdata!["price"].toString());
      } else {
        fristname = TextEditingController();
        secondname = TextEditingController();
        Maincategory = TextEditingController();
        subcategory = TextEditingController();
        PerapareAre = TextEditingController();
        price = TextEditingController();
      }
      frist = false;
    }
    super.didChangeDependencies();
  }

  final _formKey = GlobalKey<FormState>();
  late TextEditingController fristname;
  late TextEditingController secondname;
  late TextEditingController Maincategory;
  late TextEditingController subcategory;
  late TextEditingController PerapareAre;
  late TextEditingController price;

  SuggestionsBoxController mainbox = SuggestionsBoxController();
  SuggestionsBoxController subbox = SuggestionsBoxController();
  SuggestionsBoxController prebbox = SuggestionsBoxController();

  double spaces = 5;
  @override
  Widget build(BuildContext context) {
    bool showCate = arrg["Search"];
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
                        controller: fristname,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.trim().isEmpty) {
                            return "Please enter Item frist language name";
                          } else {
                            return null;
                          }
                        },
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
                          controller: secondname,
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.trim().isEmpty) {
                              return "Please enter Item Second language name";
                            } else {
                              return null;
                            }
                          }),
                      SizedBox(
                        height: spaces,
                      ),
                      if (!showCate)
                        Text(
                          "Main category",
                        ),
                      if (!showCate)
                        SizedBox(
                          height: spaces,
                        ),
                      if (!showCate)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .3,
                              child: TypeAheadFormField<String?>(
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      value.trim().isEmpty) {
                                    return "Please enter main category";
                                  } else {
                                    return null;
                                  }
                                },
                                suggestionsBoxController: mainbox,
                                hideOnEmpty: true,
                                hideSuggestionsOnKeyboardHide: true,
                                suggestionsBoxVerticalOffset: 0,
                                textFieldConfiguration: TextFieldConfiguration(
                                  decoration: InputDecoration(
                                      hintText: "Select..",
                                      filled: true,
                                      fillColor: Colors.white,
                                      suffixIcon: Icon(
                                          Icons.keyboard_double_arrow_down)),
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
                              child: TypeAheadFormField<String?>(
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      value.trim().isEmpty) {
                                    return "Please enter Subcategory";
                                  } else {
                                    return null;
                                  }
                                },
                                suggestionsBoxController: subbox,
                                hideOnEmpty: true,
                                hideSuggestionsOnKeyboardHide: true,
                                suggestionsBoxVerticalOffset: 0,
                                textFieldConfiguration: TextFieldConfiguration(
                                  decoration: InputDecoration(
                                      hintText: "Select..",
                                      filled: true,
                                      fillColor: Colors.white,
                                      suffixIcon: Icon(
                                          Icons.keyboard_double_arrow_down)),
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
                            child: TypeAheadFormField<kitchen?>(
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    value.trim().isEmpty) {
                                  return "Please enter area";
                                } else {
                                  return null;
                                }
                              },
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
                              suggestionsCallback: (A) async {
                                final mylist = await ref
                                    .watch(Kitchencontrollerprovider)
                                    .getItems();
                                return mylist;
                              },
                              itemBuilder: (context, kitchen? itemData) {
                                return ListTile(
                                    title: Text(itemData!.areaName));
                              },
                              onSuggestionSelected: (suggestion) {
                                PerapareAre.text = suggestion!.areaName;
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
                                controller: price,
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      value.trim().isEmpty) {
                                    return "Please enter price";
                                  } else {
                                    return null;
                                  }
                                }),
                          ),
                          link != null
                              ? Container(
                                  width: MediaQuery.of(context).size.width * .5,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.white, width: 1)),
                                  child: Text(link!),
                                )
                              : ElevatedButton(
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
                                          style: TextStyle(
                                              color: Color(0xFF923D22)),
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
                          Noteandingredient(
                              title: "Add Note", page: addnote.path),
                          Noteandingredient(
                              title: "Add Ingrediants",
                              page: addIngredient.path)
                        ],
                      ),
                      SizedBox(
                        height: spaces,
                      ),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            onsave();
                          },
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
                child: TypeAheadFormField<String?>(
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
