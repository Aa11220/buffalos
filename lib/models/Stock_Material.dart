// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class StockMaterial {
  final int PK_Material_ID;
  final String MaterialName;
  final String MatType;
  final String unit;
  final double qty;
  StockMaterial({
    required this.PK_Material_ID,
    required this.MaterialName,
    required this.MatType,
    required this.unit,
    required this.qty,
  });

  StockMaterial copyWith({
    int? PK_Material_ID,
    String? MaterialName,
    String? MatType,
    String? unit,
    double? qty,
  }) {
    return StockMaterial(
      PK_Material_ID: PK_Material_ID ?? this.PK_Material_ID,
      MaterialName: MaterialName ?? this.MaterialName,
      MatType: MatType ?? this.MatType,
      unit: unit ?? this.unit,
      qty: qty ?? this.qty,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'PK_Material_ID': PK_Material_ID,
      'MaterialName': MaterialName,
      'MatType': MatType,
      'unit': unit,
      'qty': qty,
    };
  }

  factory StockMaterial.fromMap(Map<String, dynamic> map) {
    return StockMaterial(
      PK_Material_ID: map['PK_Material_ID'] as int,
      MaterialName: map['MaterialName'] as String,
      MatType: map['MatType'] as String,
      unit: map['unit'] as String,
      qty: map['qty'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory StockMaterial.fromJson(String source) =>
      StockMaterial.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'StockMaterial(PK_Material_ID: $PK_Material_ID, MaterialName: $MaterialName, MatType: $MatType, unit: $unit, qty: $qty)';
  }

  @override
  bool operator ==(covariant StockMaterial other) {
    if (identical(this, other)) return true;

    return other.PK_Material_ID == PK_Material_ID &&
        other.MaterialName == MaterialName &&
        other.MatType == MatType &&
        other.unit == unit &&
        other.qty == qty;
  }

  @override
  int get hashCode {
    return PK_Material_ID.hashCode ^
        MaterialName.hashCode ^
        MatType.hashCode ^
        unit.hashCode ^
        qty.hashCode;
  }
}
