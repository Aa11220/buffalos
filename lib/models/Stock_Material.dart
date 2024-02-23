// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class StockMaterial {
  final int PK_Store_ID;
  final int PK_Material_ID;
  final String StoreName;
  final String MaterialName;
  final String MatType;
  final String unit;
  final double Qty;
  StockMaterial({
    required this.PK_Store_ID,
    required this.PK_Material_ID,
    required this.StoreName,
    required this.MaterialName,
    required this.MatType,
    required this.unit,
    required this.Qty,
  });

  StockMaterial copyWith({
    int? PK_Store_ID,
    int? PK_Material_ID,
    String? StoreName,
    String? MaterialName,
    String? MatType,
    String? unit,
    double? Qty,
  }) {
    return StockMaterial(
      PK_Store_ID: PK_Store_ID ?? this.PK_Store_ID,
      PK_Material_ID: PK_Material_ID ?? this.PK_Material_ID,
      StoreName: StoreName ?? this.StoreName,
      MaterialName: MaterialName ?? this.MaterialName,
      MatType: MatType ?? this.MatType,
      unit: unit ?? this.unit,
      Qty: Qty ?? this.Qty,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'PK_Store_ID': PK_Store_ID,
      'PK_Material_ID': PK_Material_ID,
      'StoreName': StoreName,
      'MaterialName': MaterialName,
      'MatType': MatType,
      'unit': unit,
      'Qty': Qty,
    };
  }

  factory StockMaterial.fromMap(Map<String, dynamic> map) {
    return StockMaterial(
      PK_Store_ID: map['PK_Store_ID'] as int,
      PK_Material_ID: map['PK_Material_ID'] as int,
      StoreName: map['StoreName'] as String,
      MaterialName: map['MaterialName'] as String,
      MatType: map['MatType'] as String,
      unit: map['unit'] as String,
      Qty: map['Qty'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory StockMaterial.fromJson(String source) => StockMaterial.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'StockMaterial(PK_Store_ID: $PK_Store_ID, PK_Material_ID: $PK_Material_ID, StoreName: $StoreName, MaterialName: $MaterialName, MatType: $MatType, unit: $unit, Qty: $Qty)';
  }

  @override
  bool operator ==(covariant StockMaterial other) {
    if (identical(this, other)) return true;
  
    return 
      other.PK_Store_ID == PK_Store_ID &&
      other.PK_Material_ID == PK_Material_ID &&
      other.StoreName == StoreName &&
      other.MaterialName == MaterialName &&
      other.MatType == MatType &&
      other.unit == unit &&
      other.Qty == Qty;
  }

  @override
  int get hashCode {
    return PK_Store_ID.hashCode ^
      PK_Material_ID.hashCode ^
      StoreName.hashCode ^
      MaterialName.hashCode ^
      MatType.hashCode ^
      unit.hashCode ^
      Qty.hashCode;
  }
}
