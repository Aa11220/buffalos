// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'mm.dart';

class MmModule {
  List<mm> mylist;
  double total;
  MmModule({
    required this.mylist,
    required this.total,
  });

  MmModule copyWith({
    List<mm>? mylist,
    double? total,
  }) {
    return MmModule(
      mylist: mylist ?? this.mylist,
      total: total ?? this.total,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'mylist': mylist.map((x) => x.toMap()).toList(),
      'total': total,
    };
  }

  factory MmModule.fromMap(Map<String, dynamic> map) {
    return MmModule(
      mylist: List<mm>.from(
        (map['mylist'] as List<int>).map<mm>(
          (x) => mm.fromMap(x as Map<String, dynamic>),
        ),
      ),
      total: map['total'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory MmModule.fromJson(String source) =>
      MmModule.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'MmModule(mylist: $mylist, total: $total)';

  @override
  bool operator ==(covariant MmModule other) {
    if (identical(this, other)) return true;

    return listEquals(other.mylist, mylist) && other.total == total;
  }

  @override
  int get hashCode => mylist.hashCode ^ total.hashCode;
}
