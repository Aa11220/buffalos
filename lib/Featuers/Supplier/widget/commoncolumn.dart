import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Commoncolumn extends ConsumerStatefulWidget {
  final String? lable;
  final GlobalKey<FormFieldState>? keyy;
  final bool number;
  Commoncolumn({super.key, this.lable, this.keyy, this.number = false});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CommoncolumnState();
}

class _CommoncolumnState extends ConsumerState<Commoncolumn> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(widget.lable!),
        SizedBox(
            child: TextFormField(
          key: widget.keyy,
          initialValue: "",
          keyboardType:
              widget.number == true ? TextInputType.number : TextInputType.text,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Enter Value";
            }
            return null;
          },
        ))
      ],
    );
  }
}
