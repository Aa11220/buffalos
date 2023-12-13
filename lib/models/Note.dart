// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Note {
  final int id;
  final int? fkItemId;
  final String note;
  Note({
    required this.id,
    this.fkItemId,
    required this.note,
  });

  Note copyWith({
    int? id,
    int? fkItemId,
    String? note,
  }) {
    return Note(
      id: id ?? this.id,
      fkItemId: fkItemId ?? this.fkItemId,
      note: note ?? this.note,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'fkItemId': fkItemId,
      'note': note,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'] as int,
      fkItemId: map['fkItemId'] != null ? map['fkItemId'] as int : null,
      note: map['note'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Note.fromJson(String source) =>
      Note.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Note(id: $id, fkItemId: $fkItemId, note: $note)';

  @override
  bool operator ==(covariant Note other) {
    if (identical(this, other)) return true;

    return other.id == id && other.fkItemId == fkItemId && other.note == note;
  }

  @override
  int get hashCode => id.hashCode ^ fkItemId.hashCode ^ note.hashCode;
}
