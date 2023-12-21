import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SecondRow extends ConsumerStatefulWidget {
  const SecondRow({super.key, this.lable, this.mykey});
  final String? lable;
  final GlobalKey<FormFieldState>? mykey;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SecondRowState();
}

class _SecondRowState extends ConsumerState<SecondRow> {
  TextEditingController mine = TextEditingController(text: "");
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(widget.lable!),
        SizedBox(height: 5),
        TextFormField(
          key: widget.mykey,
          // controller: mine,
          keyboardType: TextInputType.number,
          initialValue: "",
          validator: (value) {
            if (value == null || value.isEmpty || value.trim().isEmpty) {
              return "Enter a Value";
            } else {
              return null;
            }
          },
        )
      ],
    );
  }
}
