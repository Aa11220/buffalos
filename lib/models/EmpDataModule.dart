// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class EmpData {
  final String? StartTime;
  final int? Hordercount;
  final double? price;
  final double? TotalAfterDiscount;
  final double? Cashprice;
  final double? Visaprice;
  final double? Componyprice;
  final int? ordercount;
  final int? returncount;
  final double? returnedvalue;
  final int? expensecount;
  final double? expprice;
  final double? NotPaidDelivery;
  final double? NotPaidTables;
  final double? TransferedFrom;
  final double? TransferedTo;
  final double? NetCash;
  EmpData({
    this.StartTime,
    this.Hordercount,
    this.price,
    this.TotalAfterDiscount,
    this.Cashprice,
    this.Visaprice,
    this.Componyprice,
    this.ordercount,
    this.returncount,
    this.returnedvalue,
    this.expensecount,
    this.expprice,
    this.NotPaidDelivery,
    this.NotPaidTables,
    this.TransferedFrom,
    this.TransferedTo,
    this.NetCash,
  });

  EmpData copyWith({
    double? price,
    double? TotalAfterDiscount,
    double? Cashprice,
    double? Visaprice,
    double? Componyprice,
    int? ordercount,
    int? returncount,
    double? returnedvalue,
    int? expensecount,
    double? expprice,
    double? NotPaidDelivery,
    double? NotPaidTables,
    double? TransferedFrom,
    double? TransferedTo,
    double? NetCash,
  }) {
    return EmpData(
      price: price ?? this.price,
      TotalAfterDiscount: TotalAfterDiscount ?? this.TotalAfterDiscount,
      Cashprice: Cashprice ?? this.Cashprice,
      Visaprice: Visaprice ?? this.Visaprice,
      Componyprice: Componyprice ?? this.Componyprice,
      ordercount: ordercount ?? this.ordercount,
      returncount: returncount ?? this.returncount,
      returnedvalue: returnedvalue ?? this.returnedvalue,
      expensecount: expensecount ?? this.expensecount,
      expprice: expprice ?? this.expprice,
      NotPaidDelivery: NotPaidDelivery ?? this.NotPaidDelivery,
      NotPaidTables: NotPaidTables ?? this.NotPaidTables,
      TransferedFrom: TransferedFrom ?? this.TransferedFrom,
      TransferedTo: TransferedTo ?? this.TransferedTo,
      NetCash: NetCash ?? this.NetCash,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'price': price,
      'TotalAfterDiscount': TotalAfterDiscount,
      'Cashprice': Cashprice,
      'Visaprice': Visaprice,
      'Componyprice': Componyprice,
      'ordercount': ordercount,
      'returncount': returncount,
      'returnedvalue': returnedvalue,
      'expensecount': expensecount,
      'expprice': expprice,
      'NotPaidDelivery': NotPaidDelivery,
      'NotPaidTables': NotPaidTables,
      'TransferedFrom': TransferedFrom,
      'TransferedTo': TransferedTo,
      'NetCash': NetCash,
    };
  }

  factory EmpData.fromMap(Map<String, dynamic> map) {
    return EmpData(
      StartTime: map['Table11'][0]["StartTime"] != null
          ? map['Table11'][0]['StartTime'] as String
          : null,
      Hordercount: map['Table3'][0]['ordercount'] != null
          ? map['Table3'][0]['ordercount'] as int
          : null,
      price: map['Table'][0]['price'] != null
          ? map['Table'][0]['price'] as double
          : null,
      TotalAfterDiscount: map['Table'][0]['TotalAfterDiscount'] != null
          ? map['Table'][0]['TotalAfterDiscount'] as double
          : null,
      Cashprice: map["Table"][0]['Cashprice'] != null
          ? map["Table"][0]['Cashprice'] as double
          : null,
      Visaprice: map["Table"][0]['Visaprice'] != null
          ? map["Table"][0]['Visaprice'] as double
          : null,
      Componyprice: map["Table"][0]['Componyprice'] != null
          ? map["Table"][0]['Componyprice'] as double
          : null,
      ordercount: map["Table"][0]['ordercount'] != null
          ? map["Table"][0]['ordercount'] as int
          : null,
      returncount: map["Table1"][0]['returncount'] != null
          ? map["Table1"][0]['returncount'] as int
          : null,
      returnedvalue: map["Table1"][0]['returnedvalue'] != null
          ? map["Table1"][0]['returnedvalue'] as double
          : null,
      expensecount: map["Table2"][0]['expensecount'] != null
          ? map["Table2"][0]['expensecount'] as int
          : null,
      expprice: map["Table2"][0]['price'] != null
          ? map["Table2"][0]['price'] as double
          : null,
      NotPaidDelivery: map["Table6"][0]['NotPaidDelivery'] != null
          ? map["Table6"][0]['NotPaidDelivery'] as double
          : null,
      NotPaidTables: map["Table7"][0]['NotPaidTables'] != null
          ? map["Table7"][0]['NotPaidTables'] as double
          : null,
      TransferedFrom: map["Table8"][0]['TransferedFrom'] != null
          ? map["Table8"][0]['TransferedFrom'] as double
          : null,
      TransferedTo: map["Table9"][0]['TransferedTo'] != null
          ? map["Table9"][0]['TransferedTo'] as double
          : null,
      NetCash: map["Table10"][0]['NetCash'] != null
          ? map["Table10"][0]['NetCash'] as double
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory EmpData.fromJson(String source) =>
      EmpData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'EmpData(price: $price, TotalAfterDiscount: $TotalAfterDiscount, Cashprice: $Cashprice, Visaprice: $Visaprice, Componyprice: $Componyprice, ordercount: $ordercount, returncount: $returncount, returnedvalue: $returnedvalue, expensecount: $expensecount, expprice: $expprice, NotPaidDelivery: $NotPaidDelivery, NotPaidTables: $NotPaidTables, TransferedFrom: $TransferedFrom, TransferedTo: $TransferedTo, NetCash: $NetCash)';
  }

  @override
  bool operator ==(covariant EmpData other) {
    if (identical(this, other)) return true;

    return other.price == price &&
        other.TotalAfterDiscount == TotalAfterDiscount &&
        other.Cashprice == Cashprice &&
        other.Visaprice == Visaprice &&
        other.Componyprice == Componyprice &&
        other.ordercount == ordercount &&
        other.returncount == returncount &&
        other.returnedvalue == returnedvalue &&
        other.expensecount == expensecount &&
        other.expprice == expprice &&
        other.NotPaidDelivery == NotPaidDelivery &&
        other.NotPaidTables == NotPaidTables &&
        other.TransferedFrom == TransferedFrom &&
        other.TransferedTo == TransferedTo &&
        other.NetCash == NetCash;
  }

  @override
  int get hashCode {
    return price.hashCode ^
        TotalAfterDiscount.hashCode ^
        Cashprice.hashCode ^
        Visaprice.hashCode ^
        Componyprice.hashCode ^
        ordercount.hashCode ^
        returncount.hashCode ^
        returnedvalue.hashCode ^
        expensecount.hashCode ^
        expprice.hashCode ^
        NotPaidDelivery.hashCode ^
        NotPaidTables.hashCode ^
        TransferedFrom.hashCode ^
        TransferedTo.hashCode ^
        NetCash.hashCode;
  }
}
