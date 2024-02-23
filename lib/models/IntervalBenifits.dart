// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class IntervalBenfitsModule {
  final double sum_sell;
  final double sum_return;
  final double sum_payments;
  final double sum_payreturn;
  final double profit;
  IntervalBenfitsModule({
    required this.sum_sell,
    required this.sum_return,
    required this.sum_payments,
    required this.sum_payreturn,
    required this.profit,
  });

  IntervalBenfitsModule copyWith({
    double? sum_sell,
    double? sum_return,
    double? sum_payments,
    double? sum_payreturn,
    double? profit,
  }) {
    return IntervalBenfitsModule(
      sum_sell: sum_sell ?? this.sum_sell,
      sum_return: sum_return ?? this.sum_return,
      sum_payments: sum_payments ?? this.sum_payments,
      sum_payreturn: sum_payreturn ?? this.sum_payreturn,
      profit: profit ?? this.profit,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sum_sell': sum_sell,
      'sum_return': sum_return,
      'sum_payments': sum_payments,
      'sum_payreturn': sum_payreturn,
      'profit': profit,
    };
  }

  factory IntervalBenfitsModule.fromMap(Map<String, dynamic> map) {
    return IntervalBenfitsModule(
      sum_sell: map['sum_sell'] as double,
      sum_return: map['sum_return'] as double,
      sum_payments: map['sum_payments'] as double,
      sum_payreturn: map['sum_payreturn'] as double,
      profit: map['profit'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory IntervalBenfitsModule.fromJson(String source) => IntervalBenfitsModule.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'IntervalBenfitsModule(sum_sell: $sum_sell, sum_return: $sum_return, sum_payments: $sum_payments, sum_payreturn: $sum_payreturn, profit: $profit)';
  }

  @override
  bool operator ==(covariant IntervalBenfitsModule other) {
    if (identical(this, other)) return true;
  
    return 
      other.sum_sell == sum_sell &&
      other.sum_return == sum_return &&
      other.sum_payments == sum_payments &&
      other.sum_payreturn == sum_payreturn &&
      other.profit == profit;
  }

  @override
  int get hashCode {
    return sum_sell.hashCode ^
      sum_return.hashCode ^
      sum_payments.hashCode ^
      sum_payreturn.hashCode ^
      profit.hashCode;
  }
}
