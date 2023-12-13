// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:buffalos/models/ingediants.dart';
import 'package:buffalos/models/item.dart';

class itemwithingred {
  final item it;
  final List<ingrediants> list;
  itemwithingred({
    required this.it,
    required this.list,
  });

  itemwithingred copyWith({
    item? it,
    List<ingrediants>? list,
  }) {
    return itemwithingred(
      it: it ?? this.it,
      list: list ?? this.list,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "item": {
        ...it.toMap(),
        "foodstuffsOrSupplies": true,
      },
      'itemIngrediants': list.map((x) => x.toMapapi()).toList(),
    };
  }

  factory itemwithingred.fromMap(Map<String, dynamic> map) {
    return itemwithingred(
      it: item.fromMap(map['it'] as Map<String, dynamic>),
      list: List<ingrediants>.from(
        (map['list'] as List<int>).map<ingrediants>(
          (x) => ingrediants.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory itemwithingred.fromJson(String source) =>
      itemwithingred.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'itemwithingred(it: $it, list: $list)';

  @override
  bool operator ==(covariant itemwithingred other) {
    if (identical(this, other)) return true;

    return other.it == it && listEquals(other.list, list);
  }

  @override
  int get hashCode => it.hashCode ^ list.hashCode;
}
