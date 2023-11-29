import 'package:buffalos/Featuers/Products/Controller/itemscontroller.dart';
import 'package:buffalos/Featuers/Products/Views/addandsave.dart';
import 'package:buffalos/apis/categoriesapi.dart';

import 'package:buffalos/models/Category.dart';
import 'package:buffalos/models/item.dart';
import 'package:buffalos/utility/Common%20funcation/disconnceted.dart';
import 'package:buffalos/utility/commonwidget/drawer.dart';
import 'package:buffalos/utility/lineargragr.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../../../providers/noteprovider.dart';

class productPage extends ConsumerStatefulWidget {
  productPage({super.key});
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
            appBar: AppBar(title: Text("Products"), actions: [
              Image.asset("assets/img/image005.png"),
            ]),
            body: isloading == true
                ? Center(
                    child: CircularProgressIndicator.adaptive(),
                  )
                : SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(
                        20,
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Category",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF90391E)),
                            ),
                            SizedBox(
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
                                  decoration: InputDecoration(
                                      hintText: "Select..",
                                      filled: true,
                                      fillColor: Colors.white,
                                      suffixIcon: Icon(
                                          Icons.keyboard_double_arrow_down)),
                                  controller: category,
                                ),
                                suggestionsBoxDecoration:
                                    SuggestionsBoxDecoration(),
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
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Items",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF90391E)),
                            ),
                            SizedBox(
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
                                  decoration: InputDecoration(
                                      hintText: "Select..",
                                      filled: true,
                                      fillColor: Colors.white,
                                      suffixIcon: Icon(
                                          Icons.keyboard_double_arrow_down)),
                                  controller: items,
                                ),
                                suggestionsBoxDecoration:
                                    SuggestionsBoxDecoration(),
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
                            SizedBox(
                              height: 40,
                            ),
                            Center(
                              child: Container(
                                width: 150,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Color(0xFF90391E),
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    disconnected(() {
                                      ref
                                          .read(notelistProvider.notifier)
                                          .deletall();
                                      onsave();
                                    }, context);
                                  },
                                  child: Center(
                                      child: Text(
                                    "Search item",
                                    style: TextStyle(color: Colors.white),
                                  )),
                                ),
                              ),
                            ),
                            Center(
                              child: Container(
                                margin: EdgeInsets.all(20),
                                width: 150,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Color(0xFF90391E),
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    disconnected(() {
                                      ref
                                          .read(notelistProvider.notifier)
                                          .deletall();
                                      print('connected');
                                      Navigator.of(context).pushNamed(
                                          addandsave.path,
                                          arguments: {
                                            "Search": false,
                                          });
                                    }, context);
                                  },
                                  child: Center(
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
