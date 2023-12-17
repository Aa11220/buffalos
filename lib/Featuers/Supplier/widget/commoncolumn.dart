import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Commoncolumn extends ConsumerStatefulWidget {
  final String? lable;
  Commoncolumn({super.key, this.lable});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CommoncolumnState();
}

class _CommoncolumnState extends ConsumerState<Commoncolumn> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Text(widget.lable!), SizedBox(child: TextFormField())],
    );
  }
}
