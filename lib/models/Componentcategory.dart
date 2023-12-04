// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:buffalos/models/maaterialtosend.dart';

class Componnent {
  String? materialName;

  int? fK_Unit_ID;
  List<materialtosend>? materialComponent;
  Componnent({
    this.materialName,
    this.fK_Unit_ID,
    this.materialComponent,
  });

  Componnent copyWith({
    String? materialName,
    int? fK_Unit_ID,
    List<materialtosend>? materialComponent,
  }) {
    return Componnent(
      materialName: materialName ?? this.materialName,
      fK_Unit_ID: fK_Unit_ID ?? this.fK_Unit_ID,
      materialComponent: materialComponent ?? this.materialComponent,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'materialName': materialName,
      'fK_Unit_ID': fK_Unit_ID,
      'materialComponent': materialComponent?.map((x) => x.toMap()).toList(),
    };
  }

  factory Componnent.fromMap(Map<String, dynamic> map) {
    return Componnent(
      materialName:
          map['materialName'] != null ? map['materialName'] as String : null,
      fK_Unit_ID: map['fK_Unit_ID'] != null ? map['fK_Unit_ID'] as int : null,
      materialComponent: map['materialComponent'] != null
          ? List<materialtosend>.from(
              (map['materialComponent'] as List<int>).map<materialtosend?>(
                (x) => materialtosend.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Componnent.fromJson(String source) =>
      Componnent.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Componnent(materialName: $materialName, fK_Unit_ID: $fK_Unit_ID, materialComponent: $materialComponent)';

  @override
  bool operator ==(covariant Componnent other) {
    if (identical(this, other)) return true;

    return other.materialName == materialName &&
        other.fK_Unit_ID == fK_Unit_ID &&
        listEquals(other.materialComponent, materialComponent);
  }

  @override
  int get hashCode =>
      materialName.hashCode ^ fK_Unit_ID.hashCode ^ materialComponent.hashCode;
}
