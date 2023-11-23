import 'package:buffalos/utility/commonwidget/appbar.dart';
import 'package:buffalos/utility/commonwidget/drawer.dart';
import 'package:buffalos/utility/dummy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../../../utility/lineargragr.dart';

class addIngredient extends StatefulWidget {
  const addIngredient({super.key});

  @override
  State<addIngredient> createState() => _addIngredientState();
}

class _addIngredientState extends State<addIngredient> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: linear,
      ),
      child: Scaffold(
        appBar: Customappbar(
          text: "Ingredients",
        ),
        drawer: MyDrawer(context),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back_ios),
            ),
            Fristrow(context),
            SizedBox(
              height: 10,
            ),
            Secondrow(context)
          ],
        ),
      ),
    );
  }

  Row Fristrow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            Text("Material"),
            SizedBox(
              height: 6,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * .3,
              child: TypeAheadField<String?>(
                // suggestionsBoxController: mainbox,
                hideOnEmpty: true,
                hideSuggestionsOnKeyboardHide: true,
                suggestionsBoxVerticalOffset: 0,
                textFieldConfiguration: TextFieldConfiguration(
                  decoration: InputDecoration(
                      hintText: "Select..",
                      filled: true,
                      fillColor: Colors.white,
                      suffixIcon: Icon(Icons.keyboard_double_arrow_down)),
                  // controller: Maincategory,
                ),
                suggestionsBoxDecoration: SuggestionsBoxDecoration(),
                suggestionsCallback: ClassName.getsuggest,
                itemBuilder: (context, String? itemData) {
                  return ListTile(title: Text(itemData!));
                },
                onSuggestionSelected: (suggestion) {
                  // Maincategory.text = suggestion!;
                  print(suggestion);
                },
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 32.0),
          child: CircleAvatar(
            backgroundColor: Color(0xFF90391E),
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.add),
              color: Colors.white,
            ),
          ),
        ),
        Column(
          children: [
            Text("Quantatiy"),
            SizedBox(
              height: 6,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * .3,
              child: TextField(
                decoration: InputDecoration(hintText: "Enter quantit...."),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 32.0),
          child: IconButton(
            onPressed: () {},
            icon: Icon(Icons.add),
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

Row Secondrow(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Column(
        children: [
          Text("Material"),
          SizedBox(
            height: 6,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * .3,
            child: TypeAheadField<String?>(
              // suggestionsBoxController: mainbox,
              hideOnEmpty: true,
              hideSuggestionsOnKeyboardHide: true,
              suggestionsBoxVerticalOffset: 0,
              textFieldConfiguration: TextFieldConfiguration(
                decoration: InputDecoration(
                    hintText: "Select..",
                    filled: true,
                    fillColor: Colors.white,
                    suffixIcon: Icon(Icons.keyboard_double_arrow_down)),
                // controller: Maincategory,
              ),
              suggestionsBoxDecoration: SuggestionsBoxDecoration(),
              suggestionsCallback: ClassName.getsuggest,
              itemBuilder: (context, String? itemData) {
                return ListTile(title: Text(itemData!));
              },
              onSuggestionSelected: (suggestion) {
                // Maincategory.text = suggestion!;
                print(suggestion);
              },
            ),
          ),
        ],
      ),
      Padding(
        padding: const EdgeInsets.only(top: 32.0),
        child: CircleAvatar(
          backgroundColor: Color(0xFF90391E),
          child: IconButton(
            onPressed: () {},
            icon: Icon(Icons.add),
            color: Colors.white,
          ),
        ),
      ),
      Column(
        children: [
          Text("Quantatiy"),
          SizedBox(
            height: 6,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * .3,
            child: TextField(
              decoration: InputDecoration(hintText: "Enter quantit...."),
            ),
          )
        ],
      ),
      Padding(
        padding: const EdgeInsets.only(top: 32.0),
        child: IconButton(
          onPressed: () {},
          icon: Icon(Icons.add),
          color: Colors.white,
        ),
      ),
    ],
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
      return AlertDialog(
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