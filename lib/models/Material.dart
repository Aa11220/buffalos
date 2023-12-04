// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Material {
  final int? pkMaterialId;
  final String? materialName;
  final int? mindemand;
  final int? fkUnitId;
  final bool? material;
  final double? matPrice;
  Material({
    this.pkMaterialId,
    this.materialName,
    this.mindemand,
    this.fkUnitId,
    this.material,
    this.matPrice,
  });

  Material copyWith({
    int? pkMaterialId,
    String? materialName,
    int? mindemand,
    int? fkUnitId,
    bool? material,
    double? matPrice,
  }) {
    return Material(
      pkMaterialId: pkMaterialId ?? this.pkMaterialId,
      materialName: materialName ?? this.materialName,
      mindemand: mindemand ?? this.mindemand,
      fkUnitId: fkUnitId ?? this.fkUnitId,
      material: material ?? this.material,
      matPrice: matPrice ?? this.matPrice,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pkMaterialId': pkMaterialId ?? 0,
      'materialName': materialName,
      'mindemand': mindemand,
      'fkUnitId': fkUnitId,
      'material': material,
      'matPrice': matPrice,
    };
  }

  factory Material.fromMap(Map<String, dynamic> map) {
    return Material(
      pkMaterialId:
          map['pkMaterialId'] != null ? map['pkMaterialId'] as int : null,
      materialName:
          map['materialName'] != null ? map['materialName'] as String : null,
      mindemand: map['mindemand'] != null ? map['mindemand'] as int : null,
      fkUnitId: map['fkUnitId'] != null ? map['fkUnitId'] as int : null,
      material: map['material'] != null ? map['material'] as bool : null,
      matPrice: map['matPrice'] != null ? map['matPrice'] as double : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Material.fromJson(String source) =>
      Material.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Material(pkMaterialId: $pkMaterialId, materialName: $materialName, mindemand: $mindemand, fkUnitId: $fkUnitId, material: $material, matPrice: $matPrice)';
  }

  @override
  bool operator ==(covariant Material other) {
    if (identical(this, other)) return true;

    return other.pkMaterialId == pkMaterialId &&
        other.materialName == materialName &&
        other.mindemand == mindemand &&
        other.fkUnitId == fkUnitId &&
        other.material == material &&
        other.matPrice == matPrice;
  }

  @override
  int get hashCode {
    return pkMaterialId.hashCode ^
        materialName.hashCode ^
        mindemand.hashCode ^
        fkUnitId.hashCode ^
        material.hashCode ^
        matPrice.hashCode;
  }
}
