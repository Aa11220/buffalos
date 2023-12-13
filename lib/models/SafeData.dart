// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SafeData {
  final String? SafeName;
  final double? Balance;
  SafeData({
    this.SafeName,
    this.Balance,
  });

  SafeData copyWith({
    String? SafeName,
    double? Balance,
  }) {
    return SafeData(
      SafeName: SafeName ?? this.SafeName,
      Balance: Balance ?? this.Balance,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'SafeName': SafeName,
      'Balance': Balance,
    };
  }

  factory SafeData.fromMap(Map<String, dynamic> map) {
    return SafeData(
      SafeName: map['SafeName'] != null ? map['SafeName'] as String : null,
      Balance: map['Balance'] != null ? map['Balance'] as double : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SafeData.fromJson(String source) =>
      SafeData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Safe(SafeName: $SafeName, Balance: $Balance)';

  @override
  bool operator ==(covariant SafeData other) {
    if (identical(this, other)) return true;

    return other.SafeName == SafeName && other.Balance == Balance;
  }

  @override
  int get hashCode => SafeName.hashCode ^ Balance.hashCode;
}
