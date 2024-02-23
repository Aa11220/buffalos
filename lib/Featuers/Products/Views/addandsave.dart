import 'dart:ffi';
import 'dart:io';

import 'package:buffalos/models/Category.dart';
import 'package:buffalos/models/itemwithnotes.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../../../apis/Category_Api_Add.dart';
import '../../../apis/categoriesapi.dart';
import '../../../apis/fileapi.dart';
import '../../../apis/subcategory.dart';
import '../../../apis/updateandadditem.dart';
import '../../../apis/updateanditemwithNotes.dart';
import '../../../models/CategoryForAdd/Categorry_For_Add.dart';
import '../../../models/item.dart';
import '../../../models/itemwithingred.dart';
import '../../../models/kitchen.dart';
import '../../../providers/igrediantsprovider.dart';
import '../../../providers/noteprovider.dart';
import '../../../utility/commonwidget/drawer.dart';
import '../../../utility/dummy.dart';
import '../../../utility/lineargragr.dart';
import '../Controller/kitchencontroller.dart';
import '../widget/ingrediants.dart';
import '../widget/notesandingrediant.dart';
import 'addingred.dart';
import 'addnote.dart';
import 'productspage.dart';

class addandsave extends ConsumerStatefulWidget {
  const addandsave({super.key});
  static const path = "addandsaveproducts";
  @override
  ConsumerState<addandsave> createState() => _addandsaveState();
}

class _addandsaveState extends ConsumerState<addandsave> {
  void pickfile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path!);
      ref.read(fileProvider).addfile(file, "1");
    } else {
      // User canceled the picker
    }
  }

  List<Category> _lissst = [];
  String pkstring = "";
  void update(String id, {bool inside = true}) async {
    _lissst = await ref.read(subcategoryapiProvider).getsubcat(id);
    if (inside) {
      setState(() {});
    }
  }

  late final arrg;
  late final itemdata;
  String? link;
  String iteamid = "";
  String iteamname = "";
  late bool search;
  bool frist = true;
  void onsave(bool search) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final intprice = double.tryParse(price.text) ?? 0;
      if (search) {
        print(ref.read(ingredianlistProvider));
        final loo = itemwithingred(
            it: item(
                active: true,
                fkCategoryId: catid,
                fkPrepareId: fkPrepareId,
                itemImage2: null,
                itemImage: link,
                itemName: fristname.text,
                itemNameLang2: secondname.text,
                pkItemId: iteamidint,
                price: intprice),
            list: ref.read(ingredianlistProvider));
        final bestnote = ItemWithNotes(
          it: item(
              active: true,
              fkCategoryId: catid,
              fkPrepareId: fkPrepareId,
              itemImage2: null,
              itemImage: link,
              itemName: fristname.text,
              itemNameLang2: secondname.text,
              pkItemId: iteamidint,
              price: intprice),
          note: ref.read(notelistProvider),
        );
        // print(listtt);

        await ref.read(addandupdateProvider).updatewithingrediant(loo);
        await ref.read(addandupdatenoteProvider).updatewithingrediant(bestnote);
        print(loo.toMap());
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Done")));
        Navigator.of(context).popUntil(ModalRoute.withName(productPage.path));
      } else {
        print(ref.read(ingredianlistProvider));
        final loo = itemwithingred(
            it: item(
                active: true,
                fkCategoryId: catid,
                fkPrepareId: fkPrepareId,
                itemImage2: null,
                itemImage: link,
                itemName: fristname.text,
                itemNameLang2: secondname.text,
                // pkItemId: iteamidint,
                price: intprice),
            list: ref.read(ingredianlistProvider));
        final id = await ref.read(addandupdateProvider).Addwithingrediant(loo);

        final bestnote = ItemWithNotes(
          it: item(
              active: true,
              fkCategoryId: catid,
              fkPrepareId: fkPrepareId,
              itemImage2: null,
              itemImage: "",
              itemName: fristname.text,
              itemNameLang2: secondname.text,
              pkItemId: id,
              price: intprice),
          note: ref.read(notelistProvider),
        );
        final listtt = await ref.read(subcategoryapiProvider).getsubcat("1");
        print(listtt);
        print(bestnote);
        await ref.read(addandupdatenoteProvider).updatewithingrediant(bestnote);
        print(loo.toMap());
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Done")));
        Navigator.of(context).popUntil(ModalRoute.withName(productPage.path));
      }
    }
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies

    if (frist) {
      arrg = ModalRoute.of(context)!.settings.arguments as Map;
      search = arrg['Search'];
      if (search) {
        itemdata = arrg["item"] as Map;
        fristname = TextEditingController(text: itemdata!["itemName"]);
        secondname = TextEditingController(text: itemdata!["itemNameLang2"]);
        link = itemdata!["itemImage"];
        Maincategory = TextEditingController();
        subcategory = TextEditingController();
        PerapareAre = TextEditingController(text: arrg["Kitchen"]);
        price = TextEditingController(text: itemdata!["price"].toString());
        iteamid = itemdata!["pkItemId"].toString();
        iteamidint = itemdata!["pkItemId"];
        iteamname = itemdata!["itemName"];
        fkPrepareId = itemdata["fkPrepareId"];
        catid = itemdata!["fkCategoryId"];
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
  int? iteamidint;
  int? fkPrepareId;
  int? catid;
  SuggestionsBoxController mainbox = SuggestionsBoxController();
  SuggestionsBoxController subbox = SuggestionsBoxController();
  SuggestionsBoxController prebbox = SuggestionsBoxController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  double spaces = 5;
  @override
  Widget build(BuildContext context) {
    bool showCate = arrg["Search"];
    print(showCate);
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
              title: const Text("Products"),
              actions: [Image.asset("assets/img/image005.png")],
            ),
            drawer: MyDrawer(context),
            body: Padding(
              padding: const EdgeInsets.all(12),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Item frist language name"),
                      SizedBox(
                        height: spaces,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
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
                      const Text(
                        "Item Second language name",
                      ),
                      SizedBox(
                        height: spaces,
                      ),
                      TextFormField(
                          decoration: const InputDecoration(
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
                        const Text(
                          "Main category",
                        ),
                      if (!showCate)
                        SizedBox(
                          height: spaces,
                        ),
                      if (!showCate)
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .3,
                              child: TypeAheadFormField(
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      value.trim().isEmpty) {
                                    return "Please enter main category";
                                  } else {
                                    return null;
                                  }
                                },
                                direction: AxisDirection.up,
                                suggestionsBoxController: mainbox,
                                hideOnEmpty: true,
                                hideSuggestionsOnKeyboardHide: true,
                                suggestionsBoxVerticalOffset: 0,
                                textFieldConfiguration: TextFieldConfiguration(
                                  decoration: const InputDecoration(
                                      hintText: "Select..",
                                      filled: true,
                                      fillColor: Colors.white,
                                      suffixIcon: Icon(
                                          Icons.keyboard_double_arrow_down)),
                                  controller: Maincategory,
                                ),
                                suggestionsBoxDecoration:
                                    const SuggestionsBoxDecoration(),
                                suggestionsCallback: (A) async {
                                  final mylist1 = await ref
                                      .watch(CategoriesAddApiprovider)
                                      .fetchCategoriesAdd();
                                  return mylist1.where((element) {
                                    return element.categoryName
                                        .toLowerCase()
                                        .contains(A.toLowerCase());
                                  });
                                },
                                itemBuilder: (context, itemData) {
                                  return ListTile(
                                      title: Text(itemData.categoryName));
                                },
                                onSuggestionSelected: (suggestion) async {
                                  Maincategory.text = suggestion.categoryName;
                                  catid = suggestion.pkCategory;
                                  print(suggestion);
                                  pkstring = suggestion.pkCategory.toString();
                                  update(pkstring);
                                  print(_lissst);
                                  // _lissst = await ref
                                  //     .read(subcategoryapiProvider)
                                  //     .getsubcat(
                                  //         suggestion.pkCategory.toString());
                                },
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            CircleAvatar(
                              backgroundColor: const Color(0xFF90391E),
                              child: IconButton(
                                onPressed: () => _showdialolgmain(
                                    context, Maincategory, "Main category"),
                                icon: const Icon(Icons.add),
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            (_lissst.isEmpty != true)
                                ? SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * .3,
                                    child: TypeAheadFormField<Category>(
                                      direction: AxisDirection.up,
                                      suggestionsBoxController: subbox,
                                      hideOnEmpty: true,
                                      hideSuggestionsOnKeyboardHide: true,
                                      suggestionsBoxVerticalOffset: 0,
                                      textFieldConfiguration:
                                          TextFieldConfiguration(
                                        decoration: const InputDecoration(
                                            hintText: "Select..",
                                            filled: true,
                                            fillColor: Colors.white,
                                            suffixIcon: Icon(Icons
                                                .keyboard_double_arrow_down)),
                                        controller: subcategory,
                                      ),
                                      suggestionsBoxDecoration:
                                          const SuggestionsBoxDecoration(),
                                      suggestionsCallback: (A) {
                                        if (Maincategory.text.isNotEmpty) {
                                          return _lissst;
                                        } else {
                                          return [];
                                        }
                                      },
                                      itemBuilder: (context, itemData) {
                                        return ListTile(
                                            title: Text(itemData.categoryName));
                                      },
                                      onSuggestionSelected: (suggestion) {
                                        subcategory.text =
                                            suggestion.categoryName;
                                        catid = suggestion.pkCategory;

                                        print(suggestion.categoryName);
                                      },
                                    ),
                                  )
                                : Text(
                                    "No sub Categories",
                                    style: TextStyle(color: Colors.white),
                                  ),
                            SizedBox(
                              width: 15,
                            ),
                            CircleAvatar(
                              backgroundColor: const Color(0xFF90391E),
                              child: IconButton(
                                onPressed: () {
                                  _showdialolgmainsubcategory(context,
                                      subcategory, Maincategory, subcategory);
                                },
                                icon: const Icon(Icons.add),
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      SizedBox(
                        height: spaces,
                      ),
                      const Text("Perapare Area"),
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
                              direction: AxisDirection.up,
                              hideOnEmpty: true,
                              hideSuggestionsOnKeyboardHide: true,
                              suggestionsBoxVerticalOffset: 0,
                              textFieldConfiguration: TextFieldConfiguration(
                                decoration: const InputDecoration(
                                    hintText: "Select..",
                                    filled: true,
                                    fillColor: Colors.white,
                                    suffixIcon:
                                        Icon(Icons.keyboard_double_arrow_down)),
                                controller: PerapareAre,
                              ),
                              suggestionsBoxDecoration:
                                  const SuggestionsBoxDecoration(),
                              suggestionsCallback: (A) async {
                                final mylist = await ref
                                    .watch(Kitchencontrollerprovider)
                                    .getItems();
                                return mylist.where((element) {
                                  return element.areaName
                                      .toLowerCase()
                                      .contains(A.toLowerCase());
                                });
                              },
                              itemBuilder: (context, kitchen? itemData) {
                                return ListTile(
                                    title: Text(itemData!.areaName));
                              },
                              onSuggestionSelected: (suggestion) {
                                PerapareAre.text = suggestion!.areaName;
                                fkPrepareId = suggestion.pkPrepareId;
                                print(suggestion);
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 18),
                            child: CircleAvatar(
                              backgroundColor: const Color(0xFF90391E),
                              child: IconButton(
                                onPressed: () => _showdialolgmain(
                                    context, PerapareAre, "Perapare Area",
                                    isCategory: false),
                                icon: const Icon(Icons.add),
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: spaces,
                      ),
                      const Text("price"),
                      SizedBox(
                        height: spaces,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.35,
                            child: TextFormField(
                                decoration: const InputDecoration(
                                    hintText: "Enter price...."),
                                keyboardType: TextInputType.number,
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
                          SizedBox(
                            width: 12,
                          ),
                          link != null
                              ? Expanded(
                                  child: Row(
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .4,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.white, width: 1)),
                                        child: Text(link!),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            setState(() => link = null);
                                          },
                                          icon: Icon(Icons.close))
                                    ],
                                  ),
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
                                  child: const Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Noteandingredient(
                              search: search,
                              page: addnote.path,
                              itemid: iteamid),
                          igrediants(
                            search: search,
                            page: addIngredient.path,
                            itemid: iteamid,
                            itemname: iteamname,
                          )
                        ],
                      ),
                      SizedBox(
                        height: spaces,
                      ),
                      Center(
                        child: ElevatedButton(
                          onPressed: () async {
                            // final intprice = double.tryParse(price.text) ?? 0;
                            onsave(showCate);
                            // print(ref.read(ingredianlistProvider));
                            // final loo = itemwithingred(
                            //     it: item(
                            //         active: true,
                            //         fkCategoryId: catid,
                            //         fkPrepareId: fkPrepareId,
                            //         itemImage2: null,
                            //         itemImage: "",
                            //         itemName: fristname.text,
                            //         itemNameLang2: secondname.text,
                            //         pkItemId: iteamidint,
                            //         price: intprice),
                            //     list: ref.read(ingredianlistProvider));
                            // final listtt = await ref
                            //     .read(subcategoryapiProvider)
                            //     .getsubcat("1");
                            // print(listtt);
                            // await ref
                            //     .read(addandupdateProvider)
                            //     .updatewithingrediant(loo);
                            // print(loo.toMap());
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
                            "Save",
                            style: TextStyle(color: Colors.white),
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

  Future<void> _showdialolgmainsubcategory(
      BuildContext context,
      TextEditingController controller,
      TextEditingController main,
      TextEditingController secondcontroller) {
    secondcontroller.clear();
    main.clear();
    return showAdaptiveDialog(
      context: context,
      builder: (context) {
        // secondcontroller.clear();
        String categoryid = "";
        return Consumer(
          builder: (context, ref, child) => AlertDialog.adaptive(
            title: const Text(
              "Add sub category",
              style: TextStyle(color: Color(0xFF90391E)),
            ),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("main category"),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .4,
                    child: TypeAheadFormField<CategoryForAdd>(
                      hideOnEmpty: true,
                      hideSuggestionsOnKeyboardHide: true,
                      suggestionsBoxVerticalOffset: 0,
                      textFieldConfiguration: TextFieldConfiguration(
                        onTap: () => main.clear(),
                        decoration: const InputDecoration(
                            hintText: "Select..",
                            filled: true,
                            fillColor: Colors.white,
                            suffixIcon: Icon(Icons.keyboard_double_arrow_down)),
                        controller: main,
                      ),
                      suggestionsBoxDecoration:
                          const SuggestionsBoxDecoration(),
                      suggestionsCallback: (A) async {
                        final mylist1 = await ref
                            .watch(CategoriesAddApiprovider)
                            .fetchCategoriesAdd();
                        return mylist1.where((element) {
                          return element.categoryName
                              .toLowerCase()
                              .contains(A.toLowerCase());
                        });
                      },
                      itemBuilder: (context, CategoryForAdd? itemData) {
                        return ListTile(title: Text(itemData!.categoryName));
                      },
                      onSuggestionSelected: (suggestion) {
                        main.text = suggestion.categoryName;
                        categoryid = suggestion.pkCategory.toString();
                        print(suggestion.categoryName);
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text("sub category"),
                  const SizedBox(
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
                child: const Text('cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('Save'),
                onPressed: () async {
                  if (main.text != "") {
                    List<int> check = await ref
                        .read(subcategoryapiProvider)
                        .addSubCategory(secondcontroller.text, categoryid);
                    if (check[0] == 0 && check[1] == 0) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("error happen")));
                    } else {
                      update(check[1].toString());
                      catid = check[0];
                    }
                  }

                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

Future<void> _showdialolgmain(
    BuildContext context, TextEditingController controller, String titletext,
    {bool isCategory = true}) {
  controller.clear();
  return showAdaptiveDialog(
    context: context,
    builder: (context) {
      return Consumer(
        builder: (context, ref, child) {
          return AlertDialog.adaptive(
            title: Text(
              titletext,
              style: const TextStyle(color: Color(0xFF90391E)),
            ),
            content: TextFormField(
              controller: controller,
              decoration: InputDecoration(hintText: "Enter ${titletext}"),
            ),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('Save'),
                onPressed: () async {
                  if (!isCategory) {
                    await ref
                        .read(Kitchencontrollerprovider)
                        .addkitchen(controller.text);
                  } else {
                    ref
                        .watch(CategoriesApiprovider)
                        .addCategory(controller.text);
                  }
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    },
  );
}
