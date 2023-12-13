import 'package:flutter/material.dart';

class CommonRow extends StatelessWidget {
  final String lable1;
  final String lable2;
  final String Value1;
  final String value2;
  const CommonRow({
    super.key,
    required String this.lable1,
    required String this.lable2,
    required String this.Value1,
    required String this.value2,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(child: Text(lable1)),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              height: 35,
              margin: EdgeInsets.all(15),
              child: Center(child: Text(Value1)),
            ),
          ),
          Expanded(child: Text(lable2)),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              height: 35,
              margin: EdgeInsets.all(15),
              child: Center(child: Text(value2)),
            ),
          ),
        ],
      ),
    );
  }
}
