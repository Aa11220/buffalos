// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:ffi';

class StockStore {
  final String MaterialName;
  final String MatType;
  final String Unit;
  final double TotalQty;
  StockStore({
    required this.MaterialName,
    required this.MatType,
    required this.Unit,
    required this.TotalQty,
  });

  StockStore copyWith({
    String? MaterialName,
    String? MatType,
    String? Unit,
    double? TotalQty,
  }) {
    return StockStore(
      MaterialName: MaterialName ?? this.MaterialName,
      MatType: MatType ?? this.MatType,
      Unit: Unit ?? this.Unit,
      TotalQty: TotalQty ?? this.TotalQty,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'MaterialName': MaterialName,
      'MatType': MatType,
      'Unit': Unit,
      'TotalQty': TotalQty,
    };
  }

  factory StockStore.fromMap(Map<String, dynamic> map) {
    return StockStore(
        MaterialName: map['MaterialName'] as String,
        MatType: map['MatType'] as String,
        Unit: map["Unit"] as String,
        TotalQty: map["TotalQty"] != null
            ? map["TotalQty"] as double
            : map['Qty'] as double
        // map['Qty'] != null ? map['Qty'] as double : map['qty'] as double,
        );
  }

  String toJson() => json.encode(toMap());

  factory StockStore.fromJson(String source) =>
      StockStore.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'StockStore(MaterialName: $MaterialName, MatType: $MatType, Unit: $Unit, TotalQty: $TotalQty)';
  }

  @override
  bool operator ==(covariant StockStore other) {
    if (identical(this, other)) return true;

    return other.MaterialName == MaterialName &&
        other.MatType == MatType &&
        other.Unit == Unit &&
        other.TotalQty == TotalQty;
  }

  @override
  int get hashCode {
    return MaterialName.hashCode ^
        MatType.hashCode ^
        Unit.hashCode ^
        TotalQty.hashCode;
  }
}
