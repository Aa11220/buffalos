// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SupllierModule {
  final int? pkSupplierId;
  final String? supplierName;
  final String? supplierAddress;
  final String? supplierTel;
  final double? balance;
  SupllierModule({
    this.pkSupplierId,
    this.supplierName,
    this.supplierAddress,
    this.supplierTel,
    this.balance,
  });

  SupllierModule copyWith({
    int? pkSupplierId,
    String? supplierName,
    String? supplierAddress,
    String? supplierTel,
    double? balance,
  }) {
    return SupllierModule(
      pkSupplierId: pkSupplierId ?? this.pkSupplierId,
      supplierName: supplierName ?? this.supplierName,
      supplierAddress: supplierAddress ?? this.supplierAddress,
      supplierTel: supplierTel ?? this.supplierTel,
      balance: balance ?? this.balance,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pkSupplierId': pkSupplierId,
      'supplierName': supplierName,
      'supplierAddress': supplierAddress,
      'supplierTel': supplierTel,
      'balance': balance,
    };
  }

  Map<String, dynamic> toMapsend() {
    return <String, dynamic>{
      'supplierName': supplierName,
      'supplierAddress': supplierAddress,
      'supplierTel': supplierTel,
      'balance': balance,
      "toJsonsend": balance
    };
  }

  factory SupllierModule.fromMap(Map<String, dynamic> map) {
    return SupllierModule(
      pkSupplierId:
          map['pkSupplierId'] != null ? map['pkSupplierId'] as int : null,
      supplierName:
          map['supplierName'] != null ? map['supplierName'] as String : null,
      supplierAddress: map['supplierAddress'] != null
          ? map['supplierAddress'] as String
          : null,
      supplierTel:
          map['supplierTel'] != null ? map['supplierTel'] as String : null,
      balance: map['balance'] != null ? map['balance'] as double : null,
    );
  }

  String toJson() => json.encode(toMap());
  String toJsonsend() => json.encode(toMapsend());

  factory SupllierModule.fromJson(String source) =>
      SupllierModule.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SupllierModule(pkSupplierId: $pkSupplierId, supplierName: $supplierName, supplierAddress: $supplierAddress, supplierTel: $supplierTel, balance: $balance)';
  }

  @override
  bool operator ==(covariant SupllierModule other) {
    if (identical(this, other)) return true;

    return other.pkSupplierId == pkSupplierId &&
        other.supplierName == supplierName &&
        other.supplierAddress == supplierAddress &&
        other.supplierTel == supplierTel &&
        other.balance == balance;
  }

  @override
  int get hashCode {
    return pkSupplierId.hashCode ^
        supplierName.hashCode ^
        supplierAddress.hashCode ^
        supplierTel.hashCode ^
        balance.hashCode;
  }
}
