// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

//  "pkTransfereId": "<long>",
//   "fkSafeFrom": "<integer>",
//   "fkSafeTo": "<integer>",
//   "value": "<double>",
//   "fkEmpFrom": "<long>",
// //   "fkEmpTo": "<long>",
//   "transDate": "<dateTime>",
//   "notes": "<string>",
//   "payNo": "<string>",
// //  "attachmentPath": "<string>"
class SafeTransfer {
  final int fkSafeFrom;
  final int fkSafeTo;
  final double value;
  final int fkEmpFrom;
  final String transDate;
  final String? notes;
  final String payNo;
  SafeTransfer({
    required this.fkSafeFrom,
    required this.fkSafeTo,
    required this.value,
    required this.fkEmpFrom,
    required this.transDate,
    this.notes,
    required this.payNo,
  });


  SafeTransfer copyWith({
    int? fkSafeFrom,
    int? fkSafeTo,
    double? value,
    int? fkEmpFrom,
    String? transDate,
    String? notes,
    String? payNo,
  }) {
    return SafeTransfer(
      fkSafeFrom: fkSafeFrom ?? this.fkSafeFrom,
      fkSafeTo: fkSafeTo ?? this.fkSafeTo,
      value: value ?? this.value,
      fkEmpFrom: fkEmpFrom ?? this.fkEmpFrom,
      transDate: transDate ?? this.transDate,
      notes: notes ?? this.notes,
      payNo: payNo ?? this.payNo,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fkSafeFrom': fkSafeFrom,
      'fkSafeTo': fkSafeTo,
      'value': value,
      'fkEmpFrom': fkEmpFrom,
      'transDate': transDate,
      'notes': notes,
      'payNo': payNo,
    };
  }

  factory SafeTransfer.fromMap(Map<String, dynamic> map) {
    return SafeTransfer(
      fkSafeFrom: map['fkSafeFrom'] as int,
      fkSafeTo: map['fkSafeTo'] as int,
      value: map['value'] as double,
      fkEmpFrom: map['fkEmpFrom'] as int,
      transDate: map['transDate'] as String,
      notes: map['notes'] != null ? map['notes'] as String : null,
      payNo: map['payNo'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SafeTransfer.fromJson(String source) => SafeTransfer.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SafeTransfer(fkSafeFrom: $fkSafeFrom, fkSafeTo: $fkSafeTo, value: $value, fkEmpFrom: $fkEmpFrom, transDate: $transDate, notes: $notes, payNo: $payNo)';
  }

  @override
  bool operator ==(covariant SafeTransfer other) {
    if (identical(this, other)) return true;
  
    return 
      other.fkSafeFrom == fkSafeFrom &&
      other.fkSafeTo == fkSafeTo &&
      other.value == value &&
      other.fkEmpFrom == fkEmpFrom &&
      other.transDate == transDate &&
      other.notes == notes &&
      other.payNo == payNo;
  }

  @override
  int get hashCode {
    return fkSafeFrom.hashCode ^
      fkSafeTo.hashCode ^
      value.hashCode ^
      fkEmpFrom.hashCode ^
      transDate.hashCode ^
      notes.hashCode ^
      payNo.hashCode;
  }
}
