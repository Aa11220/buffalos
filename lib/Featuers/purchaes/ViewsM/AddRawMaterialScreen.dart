import 'dart:io';
import 'package:buffalos/Featuers/Products/Views/productspage.dart';

import '../../../apis/PurchaseApi.dart';
import '../../../providers/fileProvider.dart';
import '../../../providers/materialProvider.dart';
import '../../../providers/mmprovider.dart';
import '../../../providers/purchdataprovider.dart';
import '../../../utility/commonwidget/appbar.dart';
import 'CustomCard.dart';
import 'package:buffalos/utility/commonwidget/drawer.dart';
import 'package:buffalos/utility/lineargragr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'Provider/WidList.dart';

class MAddMaterialM extends ConsumerStatefulWidget {
  const MAddMaterialM({super.key});
  static const path = "/AddMaterialM";
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MAddMaterialState();
}

bool isloading = false;

class _MAddMaterialState extends ConsumerState<MAddMaterialM> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: linear),
      child: GestureDetector(
        child: Scaffold(
          appBar: Customappbar(text: "Add Material"),
          drawer: MyDrawer(context),
          body: Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    ref.read(widlist.notifier).add(0);
                    ref.read(mmProvider.notifier).add();
                  },
                  child: Text("Add Item")),
              Consumer(
                builder: (context, ref, child) {
                  final name = ref.watch(widlist);

                  return (name.isEmpty == true)
                      ? Expanded(child: Center(child: Text("add itme")))
                      : Expanded(
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CustomCardM(
                                  index: index,
                                ),
                              );
                            },
                            itemCount: name.length,
                          ),
                        );
                },
              ),
              Consumer(
                builder: (context, ref, child) {
                  final c = ref.watch(mmProvider);
                  return Container(
                    color: Colors.white,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text("Total is : " + ((c.total)).toString()),
                          isloading == true
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : ElevatedButton(
                                  onPressed: () async {
                                    setState(() {
                                      isloading = true;
                                    });
                                    ref
                                        .read(purchasedataProvider.notifier)
                                        .setData(
                                            totalPrice:
                                                ref.read(mmProvider).total,
                                            buyMaterialDetails:
                                                ref.read(mmProvider).mylist);
                                    final kk = await ref
                                        .read(PurchaseApiProvider)
                                        .sendPurchase(
                                            ref.read(purchasedataProvider));
                                    print(
                                        ref.read(purchasedataProvider).toMap());
                                    if (ref.read(filenotifierProvider) !=
                                        null) {
                                      File file = ref
                                          .read(filenotifierProvider.notifier)
                                          .send();
                                      ref
                                          .read(PurchaseApiProvider)
                                          .addfile(file, kk.toString());
                                      print("done");
                                    }
                                    ref.invalidate(purchasedataProvider);
                                    ref.invalidate(mmProvider);
                                    ref.invalidate(itemsProvid);
                                    ref.invalidate(filenotifierProvider);
                                    setState(() {
                                      isloading = false;
                                    });
                                    Navigator.of(context).popUntil(
                                        ModalRoute.withName(productPage.path));
                                  },
                                  child: Text("Save"))
                        ]),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
