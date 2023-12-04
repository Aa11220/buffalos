// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class materialtosend {
  int? fkComponent;
  double? qty;
  double? mokQty;
  int? id;
  materialtosend({
    this.fkComponent,
    this.qty,
    this.mokQty,
    this.id,
  });

  materialtosend copyWith({
    int? fkComponent,
    double? qty,
    double? mokQty,
    int? id,
  }) {
    return materialtosend(
      fkComponent: fkComponent ?? this.fkComponent,
      qty: qty ?? this.qty,
      mokQty: mokQty ?? this.mokQty,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fkComponent': fkComponent,
      'qty': qty,
      'mokQty': mokQty,
      'id': id,
    };
  }

  factory materialtosend.fromMap(Map<String, dynamic> map) {
    return materialtosend(
      fkComponent:
          map['fkComponent'] != null ? map['fkComponent'] as int : null,
      qty: map['qty'] != null ? map['qty'] as double : null,
      mokQty: map['mokQty'] != null ? map['mokQty'] as double : null,
      id: map['id'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory materialtosend.fromJson(String source) =>
      materialtosend.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'materialtosend(fkComponent: $fkComponent, qty: $qty, mokQty: $mokQty, id: $id)';
  }

  @override
  bool operator ==(covariant materialtosend other) {
    if (identical(this, other)) return true;

    return other.fkComponent == fkComponent &&
        other.qty == qty &&
        other.mokQty == mokQty &&
        other.id == id;
  }

  @override
  int get hashCode {
    return fkComponent.hashCode ^ qty.hashCode ^ mokQty.hashCode ^ id.hashCode;
  }
}
