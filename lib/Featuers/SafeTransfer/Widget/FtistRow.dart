import 'package:buffalos/models/SafeExpress/SafeEpressModule.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../../../apis/SafeData/SafeEpress.dart';

class FristRow extends ConsumerStatefulWidget {
  const FristRow(this.onsave,
      {super.key, required this.lable, this.text = false, this.mykey});
  final String lable;
  final bool text;
  final GlobalKey? mykey;
  final void Function({
    int? fkSafeFrom,
    int? fkSafeTo,
    double? value,
    int? fkEmpFrom,
    String? transDate,
    String? notes,
    String? payNo,
  }) onsave;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FristRowState();
}

class _FristRowState extends ConsumerState<FristRow> {
  TextEditingController mine = TextEditingController();
  SafeExpressModule? text;
  TextEditingController from = TextEditingController();
  TextEditingController to = TextEditingController();
  bool? select = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(widget.lable),
        SizedBox(height: 5),
        SizedBox(
          height: 50,
          child: TypeAheadFormField(
            validator: (value) {
              if (value == null || value.isEmpty || value.trim().isEmpty) {
                return "Choose one";
              } else {
                return null;
              }
            },
            onReset: () {
              mine.clear();
              setState(() {
                select = false;
              });
            },
            key: widget.mykey,
            textFieldConfiguration: TextFieldConfiguration(
              onTap: () => mine.clear(),
              controller: mine,
              decoration: const InputDecoration(
                  hintText: "Select ...",
                  suffixIcon: Icon(Icons.keyboard_arrow_down)),
            ),
            onSuggestionSelected: (suggestion) {
              if (widget.text) {
                widget.onsave(fkSafeFrom: suggestion.fkSafeId);
              } else {
                widget.onsave(fkSafeTo: suggestion.fkSafeId);
              }

              mine.text = suggestion.safeName!;
              setState(() {
                select = true;
                text = suggestion;
              });
            },
            itemBuilder: (context, itemData) {
              return Text(itemData.safeName!);
            },
            suggestionsCallback: (A) async {
              final _list =
                  await ref.read(SafeDataExpressApiProvider).getsafeData();

              return _list.where((element) {
                return element.safeName!
                    .toLowerCase()
                    .contains(A.toLowerCase());
              });
            },
          ),
        ),
        if (select! && widget.text) Text(text!.balance!.toString())
      ],
    );
  }
}
