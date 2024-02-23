import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../../../providers/mmprovider.dart';
import '../../Products/Controller/Materialcontroller.dart';
import 'Provider/WidList.dart';

class CustomCardM extends ConsumerStatefulWidget {
  const CustomCardM({super.key, required this.index});
  final int index;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CustomCardState();
}

class _CustomCardState extends ConsumerState<CustomCardM> {
  TextEditingController material = TextEditingController();
  SuggestionsBoxController select = SuggestionsBoxController();
  TextEditingController qya = TextEditingController();
  TextEditingController price = TextEditingController();
  double qtydoub = 0;
  double pricdoub = 0;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(10),
        color: Colors.white,
        width: MediaQuery.of(context).size.width * .6,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
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
                      // ref.read(itemsProvid).add(suggestion);
                      ref.read(mmProvider.notifier).updateid(
                          index: widget.index, qty: suggestion.pkMaterialId);
                    },
                  ),
                ),
                IconButton(
                    onPressed: () {
                      ref.read(widlist.notifier).delete(widget.index);
                      ref.read(mmProvider.notifier).delete(widget.index);
                    },
                    icon: Icon(Icons.delete)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Quantatiy : "),
                SizedBox(
                    width: MediaQuery.of(context).size.width * .3,
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width * .3,
                        child: TextField(
                          onChanged: (value) {
                            qtydoub = double.tryParse(qya.text) ?? 0;
                            log(qtydoub.toString() + "qty");
                            log(pricdoub.toString() + "qty");
                            log((qtydoub * pricdoub).toString() + " result");
                            // ref
                            //     .read(purchasedataProvider.notifier)
                            //     .add(qtydoub * pricdoub);
                            ref
                                .read(mmProvider.notifier)
                                .updateqty(index: widget.index, qty: qtydoub);
                            ref.read(mmProvider.notifier).calc();
                          },
                          onTap: () => qya.clear(),
                          controller: qya,
                          keyboardType: TextInputType.number,
                        )))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("price : "),
                SizedBox(
                    width: MediaQuery.of(context).size.width * .3,
                    child: TextField(
                      onChanged: (value) {
                        pricdoub = double.tryParse(value) ?? 0;
                        log(pricdoub.toString() + "pr");
                        log(qtydoub.toString() + "pr");
                        log((qtydoub * pricdoub).toString() + "pr");
                        // ref
                        //     .read(purchasedataProvider.notifier)
                        //     .add(qtydoub * pricdoub);
                        ref
                            .read(mmProvider.notifier)
                            .updateprice(index: widget.index, price: pricdoub);
                        ref.read(mmProvider.notifier).calc();
                      },
                      onTap: () => price.clear(),
                      controller: price,
                      keyboardType: TextInputType.number,
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
