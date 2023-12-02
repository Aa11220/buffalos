import 'package:buffalos/Featuers/Products/Controller/Materialcontroller.dart';
import 'package:buffalos/Featuers/Products/Controller/UnitController.dart';
import 'package:buffalos/models/unit.dart';
import 'package:buffalos/providers/igrediantsprovider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utility/commonwidget/appbar.dart';
import '../../../utility/commonwidget/drawer.dart';
import '../../../utility/dummy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../../../models/Material.dart' as ma;
import '../../../utility/lineargragr.dart';

class addIngredient extends ConsumerStatefulWidget {
  const addIngredient({super.key});
  static const path = "/addingred";

  @override
  ConsumerState<addIngredient> createState() => _addIngredientState();
}

class _addIngredientState extends ConsumerState<addIngredient> {
  @override
  Widget build(BuildContext context) {
    final list = ref.watch(ingredianlistProvider);
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          gradient: linear,
        ),
        child: Scaffold(
          appBar: const Customappbar(
            text: "Ingredients",
          ),
          drawer: MyDrawer(context),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.arrow_back_ios),
                ),
                Fristrow(context),
                const SizedBox(
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
                            margin: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.white),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: constraints.maxWidth * .7,
                                  child: Text(list[index].MaterialName),
                                ),
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        ref
                                            .read(
                                                ingredianlistProvider.notifier)
                                            .deleteavalue(
                                                list[index].FK_MaterialID);
                                      });
                                    },
                                    icon: const Icon(Icons.delete))
                              ],
                            ),
                          );
                        },
                      );
                    },
                    itemCount: list.length,
                  ),
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
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(10.0), // radius you want
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
          ),
        ),
      ),
    );
  }
}

Consumer Fristrow(BuildContext context) {
  return Consumer(
    builder: (context, ref, child) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              const Text("Material"),
              const SizedBox(
                height: 6,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * .3,
                child: TypeAheadField<ma.Material?>(
                  // suggestionsBoxController: mainbox,
                  hideOnEmpty: true,
                  hideSuggestionsOnKeyboardHide: true,
                  suggestionsBoxVerticalOffset: 0,
                  textFieldConfiguration: const TextFieldConfiguration(
                    decoration: InputDecoration(
                        hintText: "Select..",
                        filled: true,
                        fillColor: Colors.white,
                        suffixIcon: Icon(Icons.keyboard_double_arrow_down)),
                    // controller: Maincategory,
                  ),
                  suggestionsBoxDecoration: const SuggestionsBoxDecoration(),
                  suggestionsCallback: (A) async {
                    final mylist =
                        await ref.watch(MaterialcontrollerProvider).getall();
                    return mylist.where((element) {
                      return element.materialName!
                          .toLowerCase()
                          .contains(A.toLowerCase());
                    });
                  },
                  itemBuilder: (context, ma.Material? itemData) {
                    return ListTile(title: Text(itemData!.materialName!));
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
              backgroundColor: const Color(0xFF90391E),
              child: IconButton(
                onPressed: () {
                  _showdialolgmainsubcategory(context, TextEditingController(),
                      TextEditingController(), TextEditingController());
                },
                icon: const Icon(Icons.add),
                color: Colors.white,
              ),
            ),
          ),
          Column(
            children: [
              const Text("Quantatiy"),
              const SizedBox(
                height: 6,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * .3,
                child: const TextField(
                  decoration: InputDecoration(hintText: "Enter quantit...."),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 32.0),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.add),
              color: Colors.white,
            ),
          ),
        ],
      );
    },
  );
}

Row Secondrow(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Column(
        children: [
          const Text("Component"),
          const SizedBox(
            height: 6,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * .3,
            child: TypeAheadField<String?>(
              // suggestionsBoxController: mainbox,
              hideOnEmpty: true,
              hideSuggestionsOnKeyboardHide: true,
              suggestionsBoxVerticalOffset: 0,
              textFieldConfiguration: const TextFieldConfiguration(
                decoration: InputDecoration(
                    hintText: "Select..",
                    filled: true,
                    fillColor: Colors.white,
                    suffixIcon: Icon(Icons.keyboard_double_arrow_down)),
                // controller: Maincategory,
              ),
              suggestionsBoxDecoration: const SuggestionsBoxDecoration(),
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
          backgroundColor: const Color(0xFF90391E),
          child: IconButton(
            onPressed: () {
              _showaddingrediennt(context);
            },
            icon: const Icon(Icons.add),
            color: Colors.white,
          ),
        ),
      ),
      Column(
        children: [
          const Text("Quantatiy"),
          const SizedBox(
            height: 6,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * .3,
            child: const TextField(
              decoration: InputDecoration(hintText: "Enter quantit...."),
            ),
          )
        ],
      ),
      Padding(
        padding: const EdgeInsets.only(top: 32.0),
        child: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.add),
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
      return Consumer(
        builder: (context, ref, child) {
          return AlertDialog.adaptive(
            title: const Text(
              "Add Material",
              style: TextStyle(color: Color(0xFF90391E)),
            ),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Raw material"),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: secondcontroller,
                  ),
                  const Text("Deafault unit"),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .4,
                        child: TypeAheadField<Unit?>(
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
                            controller: main,
                          ),
                          suggestionsBoxDecoration:
                              const SuggestionsBoxDecoration(),
                          suggestionsCallback: (A) async {
                            final mylist = await ref
                                .watch(UnitControllerProvider)
                                .getall();
                            return mylist.where((element) {
                              return element.unit!
                                  .toLowerCase()
                                  .contains(A.toLowerCase());
                            });
                          },
                          itemBuilder: (context, Unit? itemData) {
                            return ListTile(title: Text(itemData!.unit!));
                          },
                          onSuggestionSelected: (suggestion) {
                            // main.text = suggestion!.unit!;
                            print(suggestion);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: const Color(0xFF90391E),
                          child: IconButton(
                            onPressed: () {
                              _showunit(context);
                            },
                            icon: const Icon(
                              Icons.add,
                              size: 12,
                            ),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text("Minmum order"),
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
    },
  );
}

Future<void> _showunit(BuildContext context) {
  return showAdaptiveDialog(
    context: context,
    builder: (context) {
      return AlertDialog.adaptive(
        title: const Text("Unit"),
        content: const TextField(
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
        title: const Text("Add component"),
        content: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Column(
                    children: [
                      const Text("Component"),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .30,
                        child: TextField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            hintText: "Enter component...",
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 3, color: Color(0xFFFEF9C5)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                  width: 3, color: Color(0xFFFEF9C5)),
                            ),
                            errorBorder: const OutlineInputBorder(
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
                      const Text("Quatatiy"),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .30,
                        child: TextField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            hintText: "Enter quantit....",
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 3, color: Color(0xFFFEF9C5)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                  width: 3, color: Color(0xFFFEF9C5)),
                            ),
                            errorBorder: const OutlineInputBorder(
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
              const Text("Deafult unit"),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .4,
                    child: TypeAheadField<String?>(
                      // suggestionsBoxController: mainbox,
                      hideOnEmpty: true,
                      hideSuggestionsOnKeyboardHide: true,
                      suggestionsBoxVerticalOffset: 0,
                      textFieldConfiguration: const TextFieldConfiguration(
                        decoration: InputDecoration(
                            hintText: "Select..",
                            filled: true,
                            fillColor: Colors.white,
                            suffixIcon: Icon(Icons.keyboard_double_arrow_down)),
                        // controller: Maincategory,
                      ),
                      suggestionsBoxDecoration:
                          const SuggestionsBoxDecoration(),
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
                      backgroundColor: const Color(0xFF90391E),
                      child: IconButton(
                        onPressed: () {
                          _showunit(context);
                        },
                        icon: const Icon(Icons.add),
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
