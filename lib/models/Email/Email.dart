// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Email {
  final int PK_MailTo_ID;
  final String MailTo;
  Email({
    required this.PK_MailTo_ID,
    required this.MailTo,
  });

  Email copyWith({
    int? PK_MailTo_ID,
    String? MailTo,
  }) {
    return Email(
      PK_MailTo_ID: PK_MailTo_ID ?? this.PK_MailTo_ID,
      MailTo: MailTo ?? this.MailTo,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'PK_MailTo_ID': PK_MailTo_ID,
      'MailTo': MailTo,
    };
  }

  factory Email.fromMap(Map<String, dynamic> map) {
    return Email(
      PK_MailTo_ID: map['PK_MailTo_ID'] as int,
      MailTo: map['MailTo'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Email.fromJson(String source) =>
      Email.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Email(PK_MailTo_ID: $PK_MailTo_ID, MailTo: $MailTo)';

  @override
  bool operator ==(covariant Email other) {
    if (identical(this, other)) return true;

    return other.PK_MailTo_ID == PK_MailTo_ID && other.MailTo == MailTo;
  }

  @override
  int get hashCode => PK_MailTo_ID.hashCode ^ MailTo.hashCode;
}
