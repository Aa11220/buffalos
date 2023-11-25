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
  var rest = ["A", "B", "C"];
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
            Secondrow(context),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.46,
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
                  backgroundColor:
                      MaterialStateProperty.all<Color>(const Color(0xFF90391E)),
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
    );
  }
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
            onPressed: () {
              _showdialolgmainsubcategory(context, TextEditingController(),
                  TextEditingController(), TextEditingController());
            },
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

Row Secondrow(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Column(
        children: [
          Text("Component"),
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
            onPressed: () {
              _showaddingrediennt(context);
            },
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
      return AlertDialog.adaptive(
        title: Text(
          "Add Material",
          style: TextStyle(color: Color(0xFF90391E)),
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Raw material"),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: secondcontroller,
              ),
              Text("Deafault unit"),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
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
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor: Color(0xFF90391E),
                      child: IconButton(
                        onPressed: () {
                          _showunit(context);
                        },
                        icon: Icon(
                          Icons.add,
                          size: 12,
                        ),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text("Minmum order"),
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

Future<void> _showunit(BuildContext context) {
  return showAdaptiveDialog(
    context: context,
    builder: (context) {
      return AlertDialog.adaptive(
        title: Text("Unit"),
        content: TextField(
          decoration: InputDecoration(hintText: "Enter unit..."),
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

Future<void> _showaddingrediennt(BuildContext context) {
  return showAdaptiveDialog(
    context: context,
    builder: (context) {
      return AlertDialog.adaptive(
        title: Text("Add component"),
        content: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Column(
                    children: [
                      Text("Component"),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .30,
                        child: TextField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            hintText: "Enter component...",
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 3, color: Color(0xFFFEF9C5)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                  width: 3, color: Color(0xFFFEF9C5)),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 3, color: Color(0xFFFEF9C5)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text("Quatatiy"),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .30,
                        child: TextField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            hintText: "Enter quantit....",
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 3, color: Color(0xFFFEF9C5)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                  width: 3, color: Color(0xFFFEF9C5)),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 3, color: Color(0xFFFEF9C5)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Text("Deafult unit"),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .4,
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
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: CircleAvatar(
                      backgroundColor: Color(0xFF90391E),
                      child: IconButton(
                        onPressed: () {
                          _showunit(context);
                        },
                        icon: Icon(Icons.add),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              FittedBox(child: Fristrow(context))
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
