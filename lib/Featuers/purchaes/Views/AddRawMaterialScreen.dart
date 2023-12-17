import 'package:buffalos/Featuers/Products/Controller/Materialcontroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../../../models/Material.dart' as ma;
import '../../../utility/commonwidget/appbar.dart';
import '../../../utility/commonwidget/drawer.dart';
import '../../../utility/lineargragr.dart';

class AddRawMaterialScreen extends ConsumerStatefulWidget {
  const AddRawMaterialScreen({super.key});
  static const String path = "/Add_Raw_Material";

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddRawMaterialScreenState();
}

class _AddRawMaterialScreenState extends ConsumerState<AddRawMaterialScreen> {
  SuggestionsBoxController select = SuggestionsBoxController();

  List<ma.Material> list = [];
  TextEditingController material = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => select.close(),
        child: Container(
          decoration: BoxDecoration(gradient: linear),
          child: Scaffold(
            appBar: Customappbar(
              text: "Purchase Data",
              image: false,
            ),
            drawer: MyDrawer(context),
            body: Center(
              child: Column(children: [
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .8,
                  child: TypeAheadField(
                    textFieldConfiguration: TextFieldConfiguration(
                      onTap: () => material.clear(),
                      controller: material,
                      decoration: const InputDecoration(
                          hintText: "Select ...",
                          suffixIcon: Icon(Icons.keyboard_arrow_down)),
                    ),
                    suggestionsCallback: (A) async {
                      final _mylist =
                          await ref.read(MaterialcontrollerProvider).getall();
                      return _mylist.where((element) {
                        return element.materialName!
                            .toLowerCase()
                            .contains(A.toLowerCase());
                      });
                    },
                    suggestionsBoxController: select,
                    itemBuilder: (context, itemData) => SizedBox(
                        height: 50,
                        child: Center(child: Text(itemData.materialName!))),
                    onSuggestionSelected: (suggestion) {
                      material.text = suggestion.materialName!;
                    },
                  ),
                ),
                list.isEmpty == true
                    ? Expanded(child: Text("Select to add Raw Materials"))
                    : Expanded(
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return Center(child: Text("me"));
                          },
                          itemCount: list.length,
                        ),
                      ),
                Container(
                  color: Colors.white,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("Total: 0.0"),
                        ElevatedButton(onPressed: () {}, child: Text("Save"))
                      ]),
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
