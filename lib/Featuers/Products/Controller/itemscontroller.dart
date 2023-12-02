import '../../../apis/itemsapi.dart';
import '../../../apis/kitchensapi.dart';
import '../../../models/item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Views/addandsave.dart';

final Itemcontrollerprovider = Provider((ref) {
  final itemapi = ref.watch(itemapiProvider);
  final kitchapi = ref.watch(kitchenapiProvider);
  return Itemcontroller(itemsapi: itemapi, kitapi: kitchapi);
});

class Itemcontroller {
  final Itemsapi itemsapi;
  final kitchenapi kitapi;

  Itemcontroller({required this.itemsapi, required this.kitapi});
  Future<List<item>> getItems(String catid) async {
    if (catid == "") {
      return [];
    } else {
      final list = await itemsapi.fetchitems(catid);
      return list;
    }
  }

  Future<void> getItem(String itemid, BuildContext context) async {
    try {
      final result = await itemsapi.fetchitem(itemid);
      final kitch = await kitapi.fetchitem(result.fkPrepareId.toString());
      Navigator.of(context).pushNamed(addandsave.path, arguments: {
        "Search": true,
        "item": result.toMap(),
        "Kitchen": kitch.areaName
      });
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Error happended")));
    }
  }
}
