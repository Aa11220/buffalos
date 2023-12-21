// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class mm {
  final int? pkBuyMaterialId;
  final int? fkBuyMaterial;
  final int? fkMaterialId;
  final double? price;
  final double? qty;
  mm({
    this.pkBuyMaterialId,
    this.fkBuyMaterial,
    this.fkMaterialId,
    this.price,
    this.qty,
  });

  mm copyWith({
    int? pkBuyMaterialId,
    int? fkBuyMaterial,
    int? fkMaterialId,
    double? price,
    double? qty,
  }) {
    return mm(
      pkBuyMaterialId: pkBuyMaterialId ?? this.pkBuyMaterialId,
      fkBuyMaterial: fkBuyMaterial ?? this.fkBuyMaterial,
      fkMaterialId: fkMaterialId ?? this.fkMaterialId,
      price: price ?? this.price,
      qty: qty ?? this.qty,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pkBuyMaterialId': 0,
      'fkBuyMaterial': 0,
      'fkMaterialId': fkMaterialId,
      'price': price,
      'qty': qty,
    };
  }

  factory mm.fromMap(Map<String, dynamic> map) {
    return mm(
      pkBuyMaterialId:
          map['pkBuyMaterialId'] != null ? map['pkBuyMaterialId'] as int : null,
      fkBuyMaterial:
          map['fkBuyMaterial'] != null ? map['fkBuyMaterial'] as int : null,
      fkMaterialId:
          map['fkMaterialId'] != null ? map['fkMaterialId'] as int : null,
      price: map['price'] != null ? map['price'] as double : null,
      qty: map['qty'] != null ? map['qty'] as double : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory mm.fromJson(String source) =>
      mm.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'mm(pkBuyMaterialId: $pkBuyMaterialId, fkBuyMaterial: $fkBuyMaterial, fkMaterialId: $fkMaterialId, price: $price, qty: $qty)';
  }

  @override
  bool operator ==(covariant mm other) {
    if (identical(this, other)) return true;

    return other.pkBuyMaterialId == pkBuyMaterialId &&
        other.fkBuyMaterial == fkBuyMaterial &&
        other.fkMaterialId == fkMaterialId &&
        other.price == price &&
        other.qty == qty;
  }

  @override
  int get hashCode {
    return pkBuyMaterialId.hashCode ^
        fkBuyMaterial.hashCode ^
        fkMaterialId.hashCode ^
        price.hashCode ^
        qty.hashCode;
  }
}
