import 'package:buffalos/apis/itemsapi.dart';
import 'package:buffalos/models/item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Views/addandsave.dart';

final Itemcontrollerprovider = Provider((ref) {
  final itemapi = ref.watch(itemapiProvider);
  return Itemcontroller(itemsapi: itemapi);
});

class Itemcontroller {
  final Itemsapi itemsapi;

  Itemcontroller({required this.itemsapi});
  Future<List<item>> getItems(String catid) async {
    if (catid == "") {
      return [];
    } else {
      final list = await itemsapi.fetchitems(catid);
      return list;
    }
  }

  void getItem(String itemid, BuildContext context) async {
    try {
      final result = await itemsapi.fetchitem(itemid);
      Navigator.of(context).pushNamed(addandsave.path,
          arguments: {"Search": true, "item": result.toMap()});
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error happended")));
    }
  }
}
