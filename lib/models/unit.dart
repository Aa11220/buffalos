// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Unit {
  final int? pkUnitId;
  final String? unit;
  Unit({
    this.pkUnitId,
    this.unit,
  });

  Unit copyWith({
    int? pkUnitId,
    String? unit,
  }) {
    return Unit(
      pkUnitId: pkUnitId ?? this.pkUnitId,
      unit: unit ?? this.unit,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pkUnitId': pkUnitId,
      'unit': unit,
    };
  }

  factory Unit.fromMap(Map<String, dynamic> map) {
    return Unit(
      pkUnitId: map['pkUnitId'] != null ? map['pkUnitId'] as int : null,
      unit: map['unit'] != null ? map['unit'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Unit.fromJson(String source) =>
      Unit.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Unit(pkUnitId: $pkUnitId, unit: $unit)';

  @override
  bool operator ==(covariant Unit other) {
    if (identical(this, other)) return true;

    return other.pkUnitId == pkUnitId && other.unit == unit;
  }

  @override
  int get hashCode => pkUnitId.hashCode ^ unit.hashCode;
}
