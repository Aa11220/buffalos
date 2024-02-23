// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:buffalos/models/Note.dart';
import 'package:buffalos/models/item.dart';

class ItemWithNotes {
  final item it;
  final List<Note> note;
  ItemWithNotes({
    required this.it,
    required this.note,
  });

  ItemWithNotes copyWith({
    item? it,
    List<Note>? note,
  }) {
    return ItemWithNotes(
      it: it ?? this.it,
      note: note ?? this.note,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'item': {
        ...it.toMap(),
        "foodstuffsOrSupplies": true,
      },
      'itemNotes': note.map((x) => x.toMap()).toList(),
    };
  }

  factory ItemWithNotes.fromMap(Map<String, dynamic> map) {
    return ItemWithNotes(
      it: item.fromMap(map['it'] as Map<String, dynamic>),
      note: List<Note>.from(
        (map['note'] as List<Note>).map<Note>(
          (x) => Note.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemWithNotes.fromJson(String source) =>
      ItemWithNotes.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ItemWithNotes(it: $it, note: $note)';

  @override
  bool operator ==(covariant ItemWithNotes other) {
    if (identical(this, other)) return true;

    return other.it == it && listEquals(other.note, note);
  }

  @override
  int get hashCode => it.hashCode ^ note.hashCode;
}
