// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserApprovalResponse {
  final String Response;
  final int EmpID;
  UserApprovalResponse({
    required this.Response,
    required this.EmpID,
  });

  UserApprovalResponse copyWith({
    String? Response,
    int? EmpID,
  }) {
    return UserApprovalResponse(
      Response: Response ?? this.Response,
      EmpID: EmpID ?? this.EmpID,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Response': Response,
      'EmpID': EmpID,
    };
  }

  factory UserApprovalResponse.fromMap(Map<String, dynamic> map) {
    return UserApprovalResponse(
      Response: map['Response'] as String,
      EmpID: map['EmpID'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserApprovalResponse.fromJson(String source) =>
      UserApprovalResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'UserApprovalResponse(Response: $Response, EmpID: $EmpID)';

  @override
  bool operator ==(covariant UserApprovalResponse other) {
    if (identical(this, other)) return true;

    return other.Response == Response && other.EmpID == EmpID;
  }

  @override
  int get hashCode => Response.hashCode ^ EmpID.hashCode;
}
