// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ItemReportModule {
  final int? PK_Item_ID;
  final String? ItemName;
  final String? CategoryName;
  final double? Price;
  final int? totalQty;
  final double? TotalSales;
  ItemReportModule({
    this.PK_Item_ID,
    this.ItemName,
    this.CategoryName,
    this.Price,
    this.totalQty,
    this.TotalSales,
  });

  ItemReportModule copyWith({
    int? PK_Item_ID,
    String? ItemName,
    String? CategoryName,
    double? Price,
    int? totalQty,
    double? TotalSales,
  }) {
    return ItemReportModule(
      PK_Item_ID: PK_Item_ID ?? this.PK_Item_ID,
      ItemName: ItemName ?? this.ItemName,
      CategoryName: CategoryName ?? this.CategoryName,
      Price: Price ?? this.Price,
      totalQty: totalQty ?? this.totalQty,
      TotalSales: TotalSales ?? this.TotalSales,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'PK_Item_ID': PK_Item_ID,
      'ItemName': ItemName,
      'CategoryName': CategoryName,
      'Price': Price,
      'totalQty': totalQty,
      'TotalSales': TotalSales,
    };
  }

  factory ItemReportModule.fromMap(Map<String, dynamic> map) {
    return ItemReportModule(
      PK_Item_ID: map['PK_Item_ID'] != null ? map['PK_Item_ID'] as int : null,
      ItemName: map['ItemName'] != null ? map['ItemName'] as String : null,
      CategoryName: map['CategoryName'] != null ? map['CategoryName'] as String : null,
      Price: map['Price'] != null ? map['Price'] as double : null,
      totalQty: map['totalQty'] != null ? map['totalQty'] as int : null,
      TotalSales: map['TotalSales'] != null ? map['TotalSales'] as double : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemReportModule.fromJson(String source) => ItemReportModule.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ItemReportModule(PK_Item_ID: $PK_Item_ID, ItemName: $ItemName, CategoryName: $CategoryName, Price: $Price, totalQty: $totalQty, TotalSales: $TotalSales)';
  }

  @override
  bool operator ==(covariant ItemReportModule other) {
    if (identical(this, other)) return true;
  
    return 
      other.PK_Item_ID == PK_Item_ID &&
      other.ItemName == ItemName &&
      other.CategoryName == CategoryName &&
      other.Price == Price &&
      other.totalQty == totalQty &&
      other.TotalSales == TotalSales;
  }

  @override
  int get hashCode {
    return PK_Item_ID.hashCode ^
      ItemName.hashCode ^
      CategoryName.hashCode ^
      Price.hashCode ^
      totalQty.hashCode ^
      TotalSales.hashCode;
  }
}
