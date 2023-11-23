import 'package:buffalos/utility/commonwidget/drawer.dart';
import 'package:buffalos/utility/lineargragr.dart';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../../../utility/dummy.dart';

class productPage extends StatefulWidget {
  productPage({super.key});

  @override
  State<productPage> createState() => _productPageState();
}

class _productPageState extends State<productPage> {
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
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(
                  20,
                ),
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
                      child: TypeAheadField<String?>(
                        suggestionsBoxController: enditcategory,
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
                          controller: category,
                        ),
                        suggestionsBoxDecoration: SuggestionsBoxDecoration(),
                        suggestionsCallback: ClassName.getsuggest,
                        itemBuilder: (context, String? itemData) {
                          return ListTile(title: Text(itemData!));
                        },
                        onSuggestionSelected: (suggestion) {
                          category.text = suggestion!;
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
                      child: TypeAheadField<String?>(
                        suggestionsBoxController: endititems,
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
                          controller: items,
                        ),
                        suggestionsBoxDecoration: SuggestionsBoxDecoration(),
                        suggestionsCallback: ClassName.getsuggest,
                        itemBuilder: (context, String? itemData) {
                          return ListTile(title: Text(itemData!));
                        },
                        onSuggestionSelected: (suggestion) {
                          category.text = suggestion!;
                          print(suggestion);
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
                            print("object");
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
                            print("object");
                          },
                          child: Center(
                              child: Text(
                            "Save item",
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
    );
  }
}
