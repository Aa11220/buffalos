// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class user {
  final String token;
  final String userName;
  final String emp_ProfilePic;
  final int fkSafeId;
  final int pkEmpId;

  user({
    required this.token,
    required this.userName,
    required this.emp_ProfilePic,
    required this.fkSafeId,
    required this.pkEmpId,
  });

  user copyWith({
    String? token,
    String? userName,
    String? emp_ProfilePic,
    int? fkSafeId,
    int? pkEmpId,
  }) {
    return user(
      token: token ?? this.token,
      userName: userName ?? this.userName,
      emp_ProfilePic: emp_ProfilePic ?? this.emp_ProfilePic,
      fkSafeId: fkSafeId ?? this.fkSafeId,
      pkEmpId: pkEmpId ?? this.pkEmpId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'token': token,
      'userName': userName,
      'emp_ProfilePic': emp_ProfilePic,
      'fkSafeId': fkSafeId,
      'pkEmpId': pkEmpId,
    };
  }

  factory user.fromMap(Map<String, dynamic> map) {
    return user(
      token: map["rs"]['token'] as String,
      userName: map["rs"]["employee"]['userName'] as String,
      emp_ProfilePic: map["rs"]["employee"]['emp_ProfilePic'] as String,
      fkSafeId: map["rs"]["employee"]['fkSafeId'] as int,
      pkEmpId: map["rs"]["employee"]['pkEmpId'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory user.fromJson(String source) =>
      user.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'user(token: $token, userName: $userName, emp_ProfilePic: $emp_ProfilePic, fkSafeId: $fkSafeId, pkEmpId: $pkEmpId)';
  }

  @override
  bool operator ==(covariant user other) {
    if (identical(this, other)) return true;

    return other.token == token &&
        other.userName == userName &&
        other.emp_ProfilePic == emp_ProfilePic &&
        other.fkSafeId == fkSafeId &&
        other.pkEmpId == pkEmpId;
  }

  @override
  int get hashCode {
    return token.hashCode ^
        userName.hashCode ^
        emp_ProfilePic.hashCode ^
        fkSafeId.hashCode ^
        pkEmpId.hashCode;
  }
}

