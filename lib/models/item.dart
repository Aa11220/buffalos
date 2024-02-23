// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class item {
  int? pkItemId;
  String? itemName;
  int? fkCategoryId;
  double? price;
  bool? active;
  int? fkPrepareId;
  String? itemImage;
  String? itemImage2;
  String? itemNameLang2;
  item({
    this.pkItemId,
    this.itemName,
    this.fkCategoryId,
    this.price,
    this.active,
    this.fkPrepareId,
    this.itemImage,
    this.itemImage2,
    this.itemNameLang2,
  });

  item copyWith({
    int? pkItemId,
    String? itemName,
    int? fkCategoryId,
    double? price,
    bool? active,
    int? fkPrepareId,
    String? itemImage,
    String? itemImage2,
    String? itemNameLang2,
  }) {
    return item(
      pkItemId: pkItemId ?? this.pkItemId,
      itemName: itemName ?? this.itemName,
      fkCategoryId: fkCategoryId ?? this.fkCategoryId,
      price: price ?? this.price,
      active: active ?? this.active,
      fkPrepareId: fkPrepareId ?? this.fkPrepareId,
      itemImage: itemImage ?? this.itemImage,
      itemImage2: itemImage2 ?? this.itemImage2,
      itemNameLang2: itemNameLang2 ?? this.itemNameLang2,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pkItemId': pkItemId,
      'itemName': itemName,
      'fkCategoryId': fkCategoryId,
      'price': price,
      'active': active,
      'fkPrepareId': fkPrepareId,
      'itemImage': itemImage,
      'itemImage2': itemImage2,
      'itemNameLang2': itemNameLang2,
    };
  }

  Map<String, dynamic> toMapAdd() {
    return <String, dynamic>{
      // 'pkItemId': pkItemId,
      'itemName': itemName,
      'fkCategoryId': fkCategoryId,
      'price': price,
      'active': active,
      'fkPrepareId': fkPrepareId,
      'itemImage': itemImage,
      'itemImage2': itemImage2,
      'itemNameLang2': itemNameLang2,
    };
  }

  factory item.fromMap(Map<String, dynamic> map) {
    return item(
      pkItemId: map['pkItemId'] != null ? map['pkItemId'] as int : null,
      itemName: map['itemName'] != null ? map['itemName'] as String : null,
      fkCategoryId:
          map['fkCategoryId'] != null ? map['fkCategoryId'] as int : null,
      price: map['price'] != null ? map['price'] as double : null,
      active: map['active'] != null ? map['active'] as bool : null,
      fkPrepareId:
          map['fkPrepareId'] != null ? map['fkPrepareId'] as int : null,
      itemImage: map['itemImage'] != null ? map['itemImage'] as String : null,
      itemImage2:
          map['itemImage2'] != null ? map['itemImage2'] as String : null,
      itemNameLang2:
          map['itemNameLang2'] != null ? map['itemNameLang2'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory item.fromJson(String source) =>
      item.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'item(pkItemId: $pkItemId, itemName: $itemName, fkCategoryId: $fkCategoryId, price: $price, active: $active, fkPrepareId: $fkPrepareId, itemImage: $itemImage, itemImage2: $itemImage2, itemNameLang2: $itemNameLang2)';
  }

  @override
  bool operator ==(covariant item other) {
    if (identical(this, other)) return true;

    return other.pkItemId == pkItemId &&
        other.itemName == itemName &&
        other.fkCategoryId == fkCategoryId &&
        other.price == price &&
        other.active == active &&
        other.fkPrepareId == fkPrepareId &&
        other.itemImage == itemImage &&
        other.itemImage2 == itemImage2 &&
        other.itemNameLang2 == itemNameLang2;
  }

  @override
  int get hashCode {
    return pkItemId.hashCode ^
        itemName.hashCode ^
        fkCategoryId.hashCode ^
        price.hashCode ^
        active.hashCode ^
        fkPrepareId.hashCode ^
        itemImage.hashCode ^
        itemImage2.hashCode ^
        itemNameLang2.hashCode;
  }
}
