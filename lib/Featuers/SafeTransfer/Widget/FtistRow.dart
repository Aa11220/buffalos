import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class FristRow extends ConsumerStatefulWidget {
  const FristRow({super.key, required this.lable, this.text = false});
  final String lable;
  final bool text;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FristRowState();
}

class _FristRowState extends ConsumerState<FristRow> {
  String? text;
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
            textFieldConfiguration: TextFieldConfiguration(
              decoration: const InputDecoration(
                  hintText: "Select ...",
                  suffixIcon: Icon(Icons.keyboard_arrow_down)),
            ),
            onSuggestionSelected: (suggestion) {
              setState(() {
                select = true;
                text = suggestion;
              });
            },
            itemBuilder: (context, itemData) {
              return Text("data");
            },
            suggestionsCallback: (A) {
              return ["A"];
            },
          ),
        ),
        if (select! && widget.text) Text(text!)
      ],
    );
  }
}
