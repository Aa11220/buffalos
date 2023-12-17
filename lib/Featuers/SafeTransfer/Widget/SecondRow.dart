import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SecondRow extends ConsumerStatefulWidget {
  const SecondRow({super.key, this.lable});
  final String? lable;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SecondRowState();
}

class _SecondRowState extends ConsumerState<SecondRow> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Text(widget.lable!), SizedBox(height: 5), TextFormField()],
    );
  }
}
