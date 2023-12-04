import '../../../providers/igrediantsprovider.dart';

import '../Controller/itemscontroller.dart';
import 'addandsave.dart';
import '../../../apis/categoriesapi.dart';

import '../../../models/Category.dart';
import '../../../models/item.dart';
import '../../../utility/Common%20funcation/disconnceted.dart';
import '../../../utility/commonwidget/drawer.dart';
import '../../../utility/lineargragr.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../../../providers/noteprovider.dart';

class productPage extends ConsumerStatefulWidget {
  const productPage({super.key});
  static const path = "/product";

  @override
  ConsumerState<productPage> createState() => _productPageState();
}

class _productPageState extends ConsumerState<productPage> {
  var isloading = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController category = TextEditingController();
  TextEditingController items = TextEditingController();
  SuggestionsBoxController enditcategory = SuggestionsBoxController();
  SuggestionsBoxController endititems = SuggestionsBoxController();
  String itemname = "";
  @override
  void dispose() {
    category.dispose();
    items.dispose();
    super.dispose();
  }

  String _Categorykey = "";
  String _itemkey = "";
  void onsave() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        isloading = true;
      });

      await ref.read(Itemcontrollerprovider).getItem(_itemkey, context);

      setState(() {
        isloading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          gradient: linear,
        ),
        child: GestureDetector(
          onTap: () {
            enditcategory.close();
            endititems.close();
          },
          child: Scaffold(
            drawer: MyDrawer(context),
            appBar: AppBar(title: const Text("Products"), actions: [
              Image.asset("assets/img/image005.png"),
            ]),
            body: isloading == true
                ? const Center(
                    child: CircularProgressIndicator.adaptive(),
                  )
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(
                        20,
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Category",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF90391E)),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              width: 250,
                              height: 50,
                              child: TypeAheadFormField<Category?>(
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      value.trim().isEmpty) {
                                    return "Please Select";
                                  } else {
                                    return null;
                                  }
                                },
                                onSaved: (newValue) {},
                                suggestionsBoxController: enditcategory,
                                suggestionsBoxVerticalOffset: 0,
                                textFieldConfiguration: TextFieldConfiguration(
                                  decoration: const InputDecoration(
                                      hintText: "Select..",
                                      filled: true,
                                      fillColor: Colors.white,
                                      suffixIcon: Icon(
                                          Icons.keyboard_double_arrow_down)),
                                  controller: category,
                                ),
                                suggestionsBoxDecoration:
                                    const SuggestionsBoxDecoration(),
                                suggestionsCallback: (A) async {
                                  final mylist = await ref
                                      .watch(CategoriesApiprovider)
                                      .fetchCategories();
                                  return mylist.where((element) {
                                    return element.categoryName
                                        .toLowerCase()
                                        .contains(A.toLowerCase());
                                  });
                                },
                                itemBuilder: (context, Category? itemData) {
                                  return ListTile(
                                      title: Text(itemData!.categoryName));
                                },
                                onSuggestionSelected: (suggestion) {
                                  items.text = "";
                                  category.text = suggestion!.categoryName;
                                  _Categorykey =
                                      suggestion.pkCategory.toString();
                                  print(suggestion);
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              "Items",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF90391E)),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              width: 250,
                              height: 50,
                              child: TypeAheadFormField<item?>(
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      value.trim().isEmpty) {
                                    return "Please Select";
                                  } else {
                                    return null;
                                  }
                                },
                                onSaved: (newValue) {},
                                suggestionsBoxController: endititems,
                                suggestionsBoxVerticalOffset: 0,
                                textFieldConfiguration: TextFieldConfiguration(
                                  decoration: const InputDecoration(
                                      hintText: "Select..",
                                      filled: true,
                                      fillColor: Colors.white,
                                      suffixIcon: Icon(
                                          Icons.keyboard_double_arrow_down)),
                                  controller: items,
                                ),
                                suggestionsBoxDecoration:
                                    const SuggestionsBoxDecoration(),
                                suggestionsCallback: (A) async {
                                  final mylist = await ref
                                      .watch(Itemcontrollerprovider)
                                      .getItems(_Categorykey);
                                  return mylist.where((element) {
                                    return element.itemName!
                                        .toLowerCase()
                                        .contains(A.toLowerCase());
                                  });
                                },
                                itemBuilder: (context, item? itemData) {
                                  return ListTile(
                                      title: Text(itemData!.itemName!));
                                },
                                onSuggestionSelected: (suggestion) {
                                  items.text = suggestion!.itemName!;

                                  _itemkey = suggestion.pkItemId!.toString();
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Center(
                              child: Container(
                                width: 150,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: const Color(0xFF90391E),
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    disconnected(() {
                                      ref.invalidate(ingredianlistProvider);
                                      ref
                                          .watch(notelistProvider.notifier)
                                          .deletall();
                                      onsave();
                                    }, context);
                                  },
                                  child: const Center(
                                      child: Text(
                                    "Search item",
                                    style: TextStyle(color: Colors.white),
                                  )),
                                ),
                              ),
                            ),
                            Center(
                              child: Container(
                                margin: const EdgeInsets.all(20),
                                width: 150,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: const Color(0xFF90391E),
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    disconnected(() {
                                      ref.invalidate(ingredianlistProvider);
                                      ref
                                          .watch(notelistProvider.notifier)
                                          .deletall();
                                      print('connected');
                                      Navigator.of(context).pushNamed(
                                          addandsave.path,
                                          arguments: {
                                            "Search": false,
                                          });
                                    }, context);
                                  },
                                  child: const Center(
                                      child: Text(
                                    "Add new item",
                                    style: TextStyle(color: Colors.white),
                                  )),
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
