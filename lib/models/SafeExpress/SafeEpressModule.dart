// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

//                 "pkSafeId": 1,
//                 "safeName": "Ezdan Safe",
//                 "fkSafeId": 1,
//                 "balance": 0.00,
//                 "fkBranchId": 2,
//                 "bank": false,
//                 "safe_type": "cash"
class SafeExpressModule {
  final int? pkSafeId;
  final String? safeName;
  final int? fkSafeId;
  final double? balance;
  final int? fkBranchId;
  final bool? bank;
  final String? safe_type;
  SafeExpressModule({
    this.pkSafeId,
    this.safeName,
    this.fkSafeId,
    this.balance,
    this.fkBranchId,
    this.bank,
    this.safe_type,
  });

  SafeExpressModule copyWith({
    int? pkSafeId,
    String? safeName,
    int? fkSafeId,
    double? balance,
    int? fkBranchId,
    bool? bank,
    String? safe_type,
  }) {
    return SafeExpressModule(
      pkSafeId: pkSafeId ?? this.pkSafeId,
      safeName: safeName ?? this.safeName,
      fkSafeId: fkSafeId ?? this.fkSafeId,
      balance: balance ?? this.balance,
      fkBranchId: fkBranchId ?? this.fkBranchId,
      bank: bank ?? this.bank,
      safe_type: safe_type ?? this.safe_type,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pkSafeId': pkSafeId,
      'safeName': safeName,
      'fkSafeId': fkSafeId,
      'balance': balance,
      'fkBranchId': fkBranchId,
      'bank': bank,
      'safe_type': safe_type,
    };
  }

  factory SafeExpressModule.fromMap(Map<String, dynamic> map) {
    return SafeExpressModule(
      pkSafeId: map['pkSafeId'] != null ? map['pkSafeId'] as int : null,
      safeName: map['safeName'] != null ? map['safeName'] as String : null,
      fkSafeId: map['fkSafeId'] != null ? map['fkSafeId'] as int : null,
      balance: map['balance'] != null ? map['balance'] as double : null,
      fkBranchId: map['fkBranchId'] != null ? map['fkBranchId'] as int : null,
      bank: map['bank'] != null ? map['bank'] as bool : null,
      safe_type: map['safe_type'] != null ? map['safe_type'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SafeExpressModule.fromJson(String source) =>
      SafeExpressModule.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SafeExpressModule(pkSafeId: $pkSafeId, safeName: $safeName, fkSafeId: $fkSafeId, balance: $balance, fkBranchId: $fkBranchId, bank: $bank, safe_type: $safe_type)';
  }

  @override
  bool operator ==(covariant SafeExpressModule other) {
    if (identical(this, other)) return true;

    return other.pkSafeId == pkSafeId &&
        other.safeName == safeName &&
        other.fkSafeId == fkSafeId &&
        other.balance == balance &&
        other.fkBranchId == fkBranchId &&
        other.bank == bank &&
        other.safe_type == safe_type;
  }

  @override
  int get hashCode {
    return pkSafeId.hashCode ^
        safeName.hashCode ^
        fkSafeId.hashCode ^
        balance.hashCode ^
        fkBranchId.hashCode ^
        bank.hashCode ^
        safe_type.hashCode;
  }
}
