import 'dart:developer';

import 'package:buffalos/models/mm.dart';
import 'package:buffalos/providers/mmprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/Material.dart' as ma;
import '../../../providers/materialProvider.dart';

class CustomCard extends ConsumerStatefulWidget {
  const CustomCard({required this.index, required this.material, super.key});
  final ma.Material material;
  final int index;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CustomCardState();
}

class _CustomCardState extends ConsumerState<CustomCard> {
  TextEditingController qya = TextEditingController();
  TextEditingController price = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    qya.text = "0";
    price.text = "0";
  }

  double qtydoub = 0;
  double pricdoub = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
          child: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height * .25,
        width: MediaQuery.of(context).size.width * .6,
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(widget.material.materialName!),
              IconButton(
                  onPressed: () {
                    ref.read(itemsProvid.notifier).delete(index: widget.index);
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
                  width: 100,
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
                  ))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("price : "),
              SizedBox(
                  width: 100,
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
        ]),
      )),
    );
  }
}
