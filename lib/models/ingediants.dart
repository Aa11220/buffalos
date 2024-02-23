// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ingrediants {
  int? FK_ItemID;
  String? ItemName;
  int FK_MaterialID;
  String MaterialName;
  double Qty;
  String MatType;
  ingrediants({
    this.FK_ItemID,
    this.ItemName,
    required this.FK_MaterialID,
    required this.MaterialName,
    required this.Qty,
    required this.MatType,
  });

  ingrediants copyWith({
    int? FK_ItemID,
    String? ItemName,
    int? FK_MaterialID,
    String? MaterialName,
    double? Qty,
    String? MatType,
  }) {
    return ingrediants(
      FK_ItemID: FK_ItemID ?? this.FK_ItemID,
      ItemName: ItemName ?? this.ItemName,
      FK_MaterialID: FK_MaterialID ?? this.FK_MaterialID,
      MaterialName: MaterialName ?? this.MaterialName,
      Qty: Qty ?? this.Qty,
      MatType: MatType ?? this.MatType,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fkItemId': FK_ItemID,
      'ItemName': ItemName,
      'fkMaterialId': FK_MaterialID,
      'MaterialName': MaterialName,
      'Qty': Qty,
      'MatType': MatType,
    };
  }

  Map<String, dynamic> toMapapi() {
    return <String, dynamic>{
      'fkItemId': FK_ItemID,
      // 'ItemName': ItemName,
      'fkMaterialId': FK_MaterialID,
      // 'MaterialName': MaterialName,
      'Qty': Qty,
      // 'MatType': MatType,
    };
  }

  factory ingrediants.fromMap(Map<String, dynamic> map) {
    return ingrediants(
      FK_ItemID: map['FK_ItemID'] != null ? map['FK_ItemID'] as int : null,
      ItemName: map['ItemName'] != null ? map['ItemName'] as String : null,
      FK_MaterialID: map['FK_MaterialID'] as int,
      MaterialName: map['MaterialName'] as String,
      Qty: map['Qty'] as double,
      MatType: map['MatType'] as String,
    );
  }

  String toJson() => json.encode(toMap());
  String toJsonapi() => json.encode(toMapapi());

  factory ingrediants.fromJson(String source) =>
      ingrediants.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ingrediants(FK_ItemID: $FK_ItemID, ItemName: $ItemName, FK_MaterialID: $FK_MaterialID, MaterialName: $MaterialName, Qty: $Qty, MatType: $MatType)';
  }

  @override
  bool operator ==(covariant ingrediants other) {
    if (identical(this, other)) return true;

    return other.FK_ItemID == FK_ItemID &&
        other.ItemName == ItemName &&
        other.FK_MaterialID == FK_MaterialID &&
        other.MaterialName == MaterialName &&
        other.Qty == Qty &&
        other.MatType == MatType;
  }

  @override
  int get hashCode {
    return FK_ItemID.hashCode ^
        ItemName.hashCode ^
        FK_MaterialID.hashCode ^
        MaterialName.hashCode ^
        Qty.hashCode ^
        MatType.hashCode;
  }
}
