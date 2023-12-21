// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:buffalos/models/mm.dart';

class PurchaseDataModule {
  final int? fK_Shift_ID;
  final int? pkBuyingId;
  final int? fkSupplierId;
  final double? totalPrice;
  final String? date;
  final String? billNo;
  final bool? payment;
  final int? fkStoreId;
  final int? fkSafeId;
  final List<mm>? buyMaterialDetails;
  PurchaseDataModule({
    this.fK_Shift_ID,
    this.pkBuyingId,
    this.fkSupplierId,
    this.totalPrice,
    this.date,
    this.billNo,
    this.payment,
    this.fkStoreId,
    this.fkSafeId,
    this.buyMaterialDetails,
  });

  PurchaseDataModule copyWith({
    int? fK_Shift_ID,
    int? pkBuyingId,
    int? fkSupplierId,
    double? totalPrice,
    String? date,
    String? billNo,
    bool? payment,
    int? fkStoreId,
    int? fkSafeId,
    List<mm>? buyMaterialDetails,
  }) {
    return PurchaseDataModule(
      fK_Shift_ID: fK_Shift_ID ?? this.fK_Shift_ID,
      pkBuyingId: pkBuyingId ?? this.pkBuyingId,
      fkSupplierId: fkSupplierId ?? this.fkSupplierId,
      totalPrice: totalPrice ?? this.totalPrice,
      date: date ?? this.date,
      billNo: billNo ?? this.billNo,
      payment: payment ?? this.payment,
      fkStoreId: fkStoreId ?? this.fkStoreId,
      fkSafeId: fkSafeId ?? this.fkSafeId,
      buyMaterialDetails: buyMaterialDetails ?? this.buyMaterialDetails,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fK_Shift_ID': fK_Shift_ID,
      'buyMaterial': {
        'pkBuyingId': pkBuyingId,
        'fkSupplierId': fkSupplierId,
        'totalPrice': totalPrice,
        'date': date,
        'billNo': billNo,
        'payment': payment,
        'fkStoreId': fkStoreId,
        'fkSafeId': fkSafeId,
      },
      'buyMaterialDetails': buyMaterialDetails?.map((x) => x.toMap()).toList(),
    };
  }

  factory PurchaseDataModule.fromMap(Map<String, dynamic> map) {
    return PurchaseDataModule(
      fK_Shift_ID:
          map['fK_Shift_ID'] != null ? map['fK_Shift_ID'] as int : null,
      pkBuyingId: map['pkBuyingId'] != null ? map['pkBuyingId'] as int : null,
      fkSupplierId:
          map['fkSupplierId'] != null ? map['fkSupplierId'] as int : null,
      totalPrice:
          map['totalPrice'] != null ? map['totalPrice'] as double : null,
      date: map['date'] != null ? map['date'] as String : null,
      billNo: map['billNo'] != null ? map['billNo'] as String : null,
      payment: map['payment'] != null ? map['payment'] as bool : null,
      fkStoreId: map['fkStoreId'] != null ? map['fkStoreId'] as int : null,
      fkSafeId: map['fkSafeId'] != null ? map['fkSafeId'] as int : null,
      buyMaterialDetails: map['buyMaterialDetails'] != null
          ? List<mm>.from(
              (map['buyMaterialDetails'] as List<int>).map<mm?>(
                (x) => mm.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PurchaseDataModule.fromJson(String source) =>
      PurchaseDataModule.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PurchaseDataModule(fK_Shift_ID: $fK_Shift_ID, pkBuyingId: $pkBuyingId, fkSupplierId: $fkSupplierId, totalPrice: $totalPrice, date: $date, billNo: $billNo, payment: $payment, fkStoreId: $fkStoreId, fkSafeId: $fkSafeId, buyMaterialDetails: $buyMaterialDetails)';
  }

  @override
  bool operator ==(covariant PurchaseDataModule other) {
    if (identical(this, other)) return true;

    return other.fK_Shift_ID == fK_Shift_ID &&
        other.pkBuyingId == pkBuyingId &&
        other.fkSupplierId == fkSupplierId &&
        other.totalPrice == totalPrice &&
        other.date == date &&
        other.billNo == billNo &&
        other.payment == payment &&
        other.fkStoreId == fkStoreId &&
        other.fkSafeId == fkSafeId &&
        listEquals(other.buyMaterialDetails, buyMaterialDetails);
  }

  @override
  int get hashCode {
    return fK_Shift_ID.hashCode ^
        pkBuyingId.hashCode ^
        fkSupplierId.hashCode ^
        totalPrice.hashCode ^
        date.hashCode ^
        billNo.hashCode ^
        payment.hashCode ^
        fkStoreId.hashCode ^
        fkSafeId.hashCode ^
        buyMaterialDetails.hashCode;
  }
}
