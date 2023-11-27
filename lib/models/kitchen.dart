// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class kitchen {
  final int pkPrepareId;
  final String areaName;

  kitchen({
    required this.pkPrepareId,
    required this.areaName,
  });

  kitchen copyWith({
    int? pkPrepareId,
    String? areaName,
  }) {
    return kitchen(
      pkPrepareId: pkPrepareId ?? this.pkPrepareId,
      areaName: areaName ?? this.areaName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pkPrepareId': pkPrepareId,
      'areaName': areaName,
    };
  }

  factory kitchen.fromMap(Map<String, dynamic> map) {
    return kitchen(
      pkPrepareId: map['pkPrepareId'] as int,
      areaName: map['areaName'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory kitchen.fromJson(String source) =>
      kitchen.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'kitchen(pkPrepareId: $pkPrepareId, areaName: $areaName)';

  @override
  bool operator ==(covariant kitchen other) {
    if (identical(this, other)) return true;

    return other.pkPrepareId == pkPrepareId && other.areaName == areaName;
  }

  @override
  int get hashCode => pkPrepareId.hashCode ^ areaName.hashCode;
}
