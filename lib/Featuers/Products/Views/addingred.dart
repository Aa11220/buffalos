import 'dart:math';

import '../Controller/componentcontroller.dart';
import '../../../models/Componentcategory.dart';

import '../../../models/maaterialtosend.dart';
import '../../../providers/ingredtosend.dart';
import '../Controller/Materialcontroller.dart';
import '../Controller/UnitController.dart';
import '../../../models/ingediants.dart';
import '../../../models/unit.dart';
import '../../../providers/igrediantsprovider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/compingredprovider.dart';
import '../../../utility/commonwidget/appbar.dart';
import '../../../utility/commonwidget/drawer.dart';
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
  String? itemidstring;
  int? itemid;
  String? itename;
  TextEditingController material = TextEditingController();
  TextEditingController materialqty = TextEditingController();
  TextEditingController materialqty2 = TextEditingController();
  TextEditingController Compomnetmaterial = TextEditingController();

  TextEditingController unit = TextEditingController();
  TextEditingController Compomnetunit = TextEditingController();

  TextEditingController addunit = TextEditingController();

  TextEditingController rawname = TextEditingController();
  TextEditingController rawqunataty = TextEditingController();

  TextEditingController cname = TextEditingController();
  TextEditingController cqunataty = TextEditingController();

  TextEditingController caddname = TextEditingController();
  TextEditingController caddquant = TextEditingController();
  TextEditingController caddunit = TextEditingController();
  @override
  void dispose() {
    material.dispose();
    materialqty.dispose();
    materialqty2.dispose();
    Compomnetmaterial.dispose();
    unit.dispose();
    Compomnetunit.dispose();
    addunit.dispose();
    rawname.dispose();
    rawqunataty.dispose();
    caddname.dispose();
    caddquant.dispose();
    caddunit.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final list = ref.watch(ingredianlistProvider);
    final itemdata = ModalRoute.of(context)!.settings.arguments as Map;
    if (itemdata["search"]) {
      itemidstring = itemdata["id"];
      itemid = int.tryParse(itemidstring!)!;
      itename = itemdata["name"];
    } else {
      itemidstring = null;
      itemid = null;
      itename = null;
    }
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          gradient: linear,
        ),
        child: Scaffold(
          appBar:  Customappbar(
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
                Fristrow(context, material, unit, addunit, rawname, rawqunataty,
                    materialqty, itemid, itename, _formKeya, caddquant),
                const SizedBox(
                  height: 10,
                ),
                Secondrow(
                    context,
                    Compomnetmaterial,
                    Compomnetunit,
                    addunit,
                    rawname,
                    rawqunataty,
                    materialqty2,
                    itemid,
                    itename,
                    cname,
                    cqunataty,
                    caddname,
                    caddquant,
                    caddunit),
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
                                  child: Column(
                                    children: [
                                      Text(list[index].MaterialName),
                                      Text(
                                          "   qty:  ${list[index].Qty}     type:  ${list[index].MatType[0] == "R" ? "M" : "C"} "),
                                    ],
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        ref
                                            .read(
                                                ingredianlistProvider.notifier)
                                            .deleteavalue(index);
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

final _formKeya = GlobalKey<FormState>();
final _formKeya2 = GlobalKey<FormState>();
int material_id = 0;
Consumer Fristrow(
    BuildContext context,
    TextEditingController material,
    TextEditingController unit,
    TextEditingController addunit,
    TextEditingController rawname,
    TextEditingController rawqunataty,
    TextEditingController materialqty,
    int? id,
    String? name,
    GlobalKey<FormState> key,
    TextEditingController secondrow,
    {bool isfrrow = true}) {
  return Consumer(
    builder: (context, ref, child) {
      void onsave() {
        if (key.currentState!.validate()) {
          key.currentState!.save();

          // if (isfrrow) {
          //   ScaffoldMessenger.of(context).showSnackBar(
          //       SnackBar(content: Text("Enter item and quantaty")));
          // }

          double qty = double.tryParse(materialqty.text)!;

          if (isfrrow == true) {
            print(material_id);
            ref.read(ingredianlistProvider.notifier).addnote(
                  ingrediants(
                      FK_ItemID: id,
                      ItemName: name,
                      FK_MaterialID: material_id,
                      MaterialName: material.text,
                      Qty: qty,
                      MatType: "RAW"),
                );
          } else {
            if (!_textFieldKey.currentState!.validate()) {
              // ScaffoldMessenger.of(context).showSnackBar(
              //     SnackBar(content: Text("It can not be empty")));
            } else {
              double amount = double.tryParse(secondrow.text)!;

              ref.read(ingrediantosendlistProvider.notifier).addnote(
                  materialtosend(
                      fkComponent: material_id,
                      id: 0,
                      qty: qty,
                      mokQty: amount));
              ref.read(ComponantProvider.notifier).addnote(
                    ingrediants(
                      FK_ItemID: id,
                      ItemName: name,
                      FK_MaterialID: material_id,
                      MaterialName: material.text,
                      Qty: qty,
                      MatType: "RAW",
                    ),
                  );
            }
          }
        }
      }

      return Form(
        key: key,
        child: Row(
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
                  child: TypeAheadFormField<ma.Material?>(
                    // suggestionsBoxController: mainbox,
                    hideOnEmpty: true,
                    hideSuggestionsOnKeyboardHide: true,
                    suggestionsBoxVerticalOffset: isfrrow == true ? 0 : 0,
                    textFieldConfiguration: TextFieldConfiguration(
                      decoration: const InputDecoration(
                          hintText: "Select..",
                          filled: true,
                          fillColor: Colors.white,
                          suffixIcon: Icon(Icons.keyboard_double_arrow_down)),
                      controller: material,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "it can not be empty";
                      }
                      return null;
                    },
                    suggestionsBoxDecoration: const SuggestionsBoxDecoration(),
                    suggestionsCallback: (A) async {
                      final mylist =
                          await ref.read(MaterialcontrollerProvider).getall();
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
                      material.text = "${suggestion!.materialName!} ";
                      material_id = suggestion.pkMaterialId!;
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
                    _showdialolgmainsubcategory(
                        context, rawname, unit, addunit, rawqunataty);
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
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "it can not be empty";
                      }
                      return null;
                    },
                    controller: materialqty,
                    decoration: const InputDecoration(hintText: "Enter quantit...."),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 32.0),
              child: IconButton(
                onPressed: () {
                  onsave();
                  material.text = "";
                  materialqty.text = "";
                },
                icon: const Icon(Icons.add),
                color: Colors.white,
              ),
            ),
          ],
        ),
      );
    },
  );
}

final _keyy = GlobalKey<FormState>();

Consumer Secondrow(
    BuildContext context,
    TextEditingController material,
    TextEditingController unit,
    TextEditingController addunit,
    TextEditingController rawname,
    TextEditingController rawqunataty,
    TextEditingController materialqty,
    int? id,
    String? name,
    TextEditingController cname,
    TextEditingController cqty,
    TextEditingController caddname,
    TextEditingController caddquant,
    TextEditingController caddunit) {
  return Consumer(
    builder: (context, ref, child) {
      void onsave() {
        if (cname.text == "" || cqty == "") {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Enter item and quantaty")));
        } else {
          if (_keyy.currentState!.validate()) {
            _keyy.currentState!.save();
            double qty = double.tryParse(cqty.text)!;

            ref.read(ingredianlistProvider.notifier).addnote(
                  ingrediants(
                      FK_ItemID: id,
                      ItemName: name,
                      FK_MaterialID: Random().nextInt(2000),
                      MaterialName: cname.text,
                      Qty: qty,
                      MatType: "Component"),
                );
          }
        }
      }

      return Form(
        key: _keyy,
        child: Row(
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
                  child: TypeAheadFormField<ma.Material?>(
                    // suggestionsBoxController: mainbox,
                    hideOnEmpty: true,
                    hideSuggestionsOnKeyboardHide: true,
                    suggestionsBoxVerticalOffset: 0,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Can not be Empty";
                      }
                      return null;
                    },
                    textFieldConfiguration: TextFieldConfiguration(
                      decoration: const InputDecoration(
                          hintText: "Select..",
                          filled: true,
                          fillColor: Colors.white,
                          suffixIcon: Icon(Icons.keyboard_double_arrow_down)),
                      controller: cname,
                    ),
                    suggestionsBoxDecoration: const SuggestionsBoxDecoration(),
                    suggestionsCallback: (A) async {
                      final mylist = await ref
                          .read(componentcontrollerProvider)
                          .fetchitems();
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
                      cname.text = suggestion!.materialName!;
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
                    _showaddingrediennt(
                      context,
                      material,
                      unit,
                      addunit,
                      rawname,
                      rawqunataty,
                      materialqty,
                      id,
                      name,
                      caddname,
                      caddquant,
                      caddunit,
                    );
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
                  child: TextFormField(
                    validator: (value) {
                      if (value == "" || value == null || value.isEmpty) {
                        return "can not be Empty";
                      }
                      return null;
                    },
                    controller: cqty,
                    decoration: const InputDecoration(hintText: "Enter quantit...."),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 32.0),
              child: IconButton(
                onPressed: () {
                  onsave();
                  cname.text = "";
                  cqty.text = "";
                },
                icon: const Icon(Icons.add),
                color: Colors.white,
              ),
            ),
          ],
        ),
      );
    },
  );
}

Future<void> _showdialolgmainsubcategory(
    BuildContext context,
    TextEditingController controller,
    TextEditingController secondcontroller,
    TextEditingController addunit,
    TextEditingController rawqunataty) {
  final formKey = GlobalKey<FormState>();
  return showAdaptiveDialog(
    context: context,
    builder: (context) {
      int id = 0;
      return Consumer(
        builder: (context, ref, child) {
          void onsave(ma.Material item) {
            if (formKey.currentState!.validate()) {
              formKey.currentState!.save();
              ref.read(MaterialcontrollerProvider).addMaterial(item);

              Navigator.of(context).pop();
            }
          }

          return AlertDialog.adaptive(
            title: const Text(
              "Add Material",
              style: TextStyle(color: Color(0xFF90391E)),
            ),
            content: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("Raw material"),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: controller,
                      onSaved: (newValue) {
                        newValue;
                      },
                      validator: (value) {
                        print(value);
                        if (value == null || value.isEmpty) {
                          return "Can not be empety";
                        }
                        return null;
                      },
                    ),
                    const Text("Deafault unit"),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .4,
                          child: TypeAheadFormField<Unit?>(
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
                              controller: secondcontroller,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Can not be empety";
                              }
                              return null;
                            },
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
                              secondcontroller.text = suggestion!.unit!;
                              id = suggestion.pkUnitId!;
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
                                _showunit(context, addunit);
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
                    TextFormField(
                      onSaved: (newValue) {},
                      keyboardType: TextInputType.number,
                      controller: rawqunataty,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Can not be empety";
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('Disable'),
                onPressed: () {
                  controller.text = "";
                  rawqunataty.text = "";
                  secondcontroller.text = "";
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('Enable'),
                onPressed: () {
                  int amount = int.tryParse(rawqunataty.text) ?? 0;
                  ma.Material k = ma.Material(
                      pkMaterialId: 0,
                      fkUnitId: id,
                      matPrice: null,
                      material: false,
                      materialName: controller.text,
                      mindemand: amount);
                  onsave(k);
                  controller.text = "";
                  rawqunataty.text = "";
                  secondcontroller.text = "";
                },
              ),
            ],
          );
        },
      );
    },
  );
}

Future<void> _showunit(BuildContext context, TextEditingController addunit) {
  return showAdaptiveDialog(
    context: context,
    builder: (context) {
      return Consumer(
        builder: (context, ref, child) {
          return AlertDialog.adaptive(
            title: const Text("Unit"),
            content: TextField(
              decoration: const InputDecoration(hintText: "Enter unit..."),
              controller: addunit,
            ),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('Disable'),
                onPressed: () {
                  addunit.text = "";
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('Enable'),
                onPressed: () {
                  print(addunit.text);
                  ref.read(UnitControllerProvider).addunit(addunit.text);
                  addunit.text = "";
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

final _compkey = GlobalKey<FormState>();
final GlobalKey<FormFieldState<String>> _textFieldKey = GlobalKey();

Future<void> _showaddingrediennt(
  BuildContext context,
  TextEditingController material,
  TextEditingController unit,
  TextEditingController addunit,
  TextEditingController rawname,
  TextEditingController rawqunataty,
  TextEditingController materialqty,
  int? id,
  String? name,
  TextEditingController caddname,
  TextEditingController caddquant,
  TextEditingController caddunit,
) {
  return showAdaptiveDialog(
    context: context,
    builder: (context) {
      int id = 0;
      return Consumer(
        builder: (context, ref, child) {
          void onsave() {
            if (_compkey.currentState!.validate()) {
              _keyy.currentState!.save();
              print(id);
              print(caddname.text);
              print(caddquant.text);
              print(ref.read(ingrediantosendlistProvider));

              final done = Componnent(
                  materialName: caddname.text,
                  fK_Unit_ID: id,
                  materialComponent: ref.read(ingrediantosendlistProvider));
              ref.read(componentcontrollerProvider).addMaterial(done);
            }
          }

          return AlertDialog.adaptive(
            title: const Text("Add component"),
            content: SingleChildScrollView(child: Consumer(
              builder: (context, ref, child) {
                return Form(
                  key: _compkey,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        children: [
                          Column(
                            children: [
                              const Text("Component"),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * .30,
                                child: TextFormField(
                                  controller: caddname,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'It can not be Empty';
                                    }
                                    return null;
                                  },
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
                                child: TextFormField(
                                  key: _textFieldKey,
                                  controller: caddquant,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'It can not be Empty';
                                    }
                                    return null;
                                  },
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
                            child: TypeAheadFormField<Unit?>(
                              // suggestionsBoxController: mainbox,
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
                                controller: caddunit,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'It can not be Empty';
                                }
                                return null;
                              },

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
                                caddunit.text = suggestion!.unit!;
                                id = suggestion.pkUnitId!;
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
                                  _showunit(context, addunit);
                                },
                                icon: const Icon(Icons.add),
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      FittedBox(
                          child: Fristrow(
                              context,
                              material,
                              unit,
                              addunit,
                              rawname,
                              rawqunataty,
                              materialqty,
                              id,
                              name,
                              _formKeya2,
                              caddquant,
                              isfrrow: false)),
                      Consumer(
                        builder: (context, ref, child) {
                          final list = ref.watch(ComponantProvider);
                          return SizedBox(
                            height: /* MediaQuery.of(context).size.height * 0.46 */
                                300,
                            width: 350,
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return LayoutBuilder(
                                  builder: (context, constraints) {
                                    return Container(
                                      padding: const EdgeInsets.all(12.0),
                                      margin: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: Colors.white),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: constraints.maxWidth * .6,
                                            child: Column(
                                              children: [
                                                Text(
                                                    list[index].MaterialName),
                                                Text(
                                                    "   qty:  ${list[index].Qty}     type:  ${list[index].MatType[0] == "R" ? "M" : "C"} "),
                                              ],
                                            ),
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                ref
                                                    .read(
                                                        ingrediantosendlistProvider
                                                            .notifier)
                                                    .deleteavalue(index);
                                                ref
                                                    .read(ComponantProvider
                                                        .notifier)
                                                    .deleteavalue(index);
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
                          );
                        },
                      )
                    ],
                  ),
                );
              },
            )),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('Disable'),
                onPressed: () {
                  caddname.text = "";
                  caddquant.text = "";
                  caddunit.text = "";
                  ref.read(ComponantProvider.notifier).deletall();
                  ref.read(ingrediantosendlistProvider.notifier).deletall();
                  _formKeya2.currentState!.reset();
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('Enable'),
                onPressed: () {
                  // final item = Componnent(
                  //     fK_Unit_ID: id,
                  //     materialName: caddname.text,
                  //     mindemand: caddquant.text,
                  //     materialComponent: );
                  onsave();
                  caddname.text = "";
                  caddquant.text = "";
                  caddunit.text = "";
                  ref.read(ComponantProvider.notifier).deletall();
                  ref.read(ingrediantosendlistProvider.notifier).deletall();
                  _formKeya2.currentState!.reset();
                },
              ),
            ],
          );
        },
      );
    },
  );
}
