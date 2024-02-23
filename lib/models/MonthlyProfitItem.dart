// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class MonthlyProfitItem {
  final double? Sales;
  final double? Spendings;
  final double? Purchase;
  final double? Main_safe_expenses;
  final double? Main_safe_Purchase_invoices;
  final double? Bank_deposit;
  final double? Withdrawals;
  MonthlyProfitItem({
    this.Sales,
    this.Spendings,
    this.Purchase,
    this.Main_safe_expenses,
    this.Main_safe_Purchase_invoices,
    this.Bank_deposit,
    this.Withdrawals,
  });

  MonthlyProfitItem copyWith({
    double? Sales,
    double? Spendings,
    double? Purchase,
    double? Main_safe_expenses,
    double? Main_safe_Purchase_invoices,
    double? Bank_deposit,
    double? Withdrawals,
  }) {
    return MonthlyProfitItem(
      Sales: Sales ?? this.Sales,
      Spendings: Spendings ?? this.Spendings,
      Purchase: Purchase ?? this.Purchase,
      Main_safe_expenses: Main_safe_expenses ?? this.Main_safe_expenses,
      Main_safe_Purchase_invoices:
          Main_safe_Purchase_invoices ?? this.Main_safe_Purchase_invoices,
      Bank_deposit: Bank_deposit ?? this.Bank_deposit,
      Withdrawals: Withdrawals ?? this.Withdrawals,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Sales': Sales,
      'Spendings': Spendings,
      'Purchase': Purchase,
      'Main_safe_expenses': Main_safe_expenses,
      'Main_safe_Purchase_invoices': Main_safe_Purchase_invoices,
      'Bank_deposit': Bank_deposit,
      'Withdrawals': Withdrawals,
    };
  }

  double total() {
    return (Sales ?? 0) +
        (Spendings ?? 0) +
        (Purchase ?? 0) +
        (Main_safe_expenses ?? 0) +
        (Main_safe_Purchase_invoices ?? 0) +
        (Bank_deposit ?? 0) +
        (Withdrawals ?? 0);
  }

  factory MonthlyProfitItem.fromMap(Map<String, dynamic> map) {
    return MonthlyProfitItem(
      Sales: map[0]["mon"] != null ? (map[0]["mon"] as double).abs() : null,
      Spendings: map[1]["mon"] != null ? (map[1]["mon"] as double).abs() : null,
      Purchase: map[2]["mon"] != null ? (map[2]["mon"] as double).abs() : null,
      Main_safe_expenses:
          map[3]["mon"] != null ? (map[3]["mon"] as double).abs() : null,
      Main_safe_Purchase_invoices:
          map[4]["mon"] != null ? (map[4]["mon"] as double).abs() : null,
      Bank_deposit:
          map[5]["mon"] != null ? (map[5]["mon"] as double).abs() : null,
      Withdrawals:
          map[6]["mon"] != null ? (map[6]["mon"] as double).abs() : null,
    );
  }
  factory MonthlyProfitItem.fromlist(List map) {
    return MonthlyProfitItem(
      Sales: map[0]["mon"] != null ? (map[0]["mon"] as double).abs() : null,
      Spendings: map[1]["mon"] != null ? (map[1]["mon"] as double).abs() : null,
      Purchase: map[2]["mon"] != null ? (map[2]["mon"] as double).abs() : null,
      Main_safe_expenses:
          map[3]["mon"] != null ? (map[3]["mon"] as double).abs() : null,
      Main_safe_Purchase_invoices:
          map[4]["mon"] != null ? (map[4]["mon"] as double).abs() : null,
      Bank_deposit:
          map[5]["mon"] != null ? (map[5]["mon"] as double).abs() : null,
      Withdrawals:
          map[6]["mon"] != null ? (map[6]["mon"] as double).abs() : null,
    );
  }
  String toJson() => json.encode(toMap());

  factory MonthlyProfitItem.fromJson(String source) =>
      MonthlyProfitItem.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MonthlyProfitItem(Sales: $Sales, Spendings: $Spendings, Purchase: $Purchase, Main_safe_expenses: $Main_safe_expenses, Main_safe_Purchase_invoices: $Main_safe_Purchase_invoices, Bank_deposit: $Bank_deposit, Withdrawals: $Withdrawals)';
  }

  @override
  bool operator ==(covariant MonthlyProfitItem other) {
    if (identical(this, other)) return true;

    return other.Sales == Sales &&
        other.Spendings == Spendings &&
        other.Purchase == Purchase &&
        other.Main_safe_expenses == Main_safe_expenses &&
        other.Main_safe_Purchase_invoices == Main_safe_Purchase_invoices &&
        other.Bank_deposit == Bank_deposit &&
        other.Withdrawals == Withdrawals;
  }

  @override
  int get hashCode {
    return Sales.hashCode ^
        Spendings.hashCode ^
        Purchase.hashCode ^
        Main_safe_expenses.hashCode ^
        Main_safe_Purchase_invoices.hashCode ^
        Bank_deposit.hashCode ^
        Withdrawals.hashCode;
  }
}
