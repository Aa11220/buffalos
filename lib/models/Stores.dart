// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Stores {
  final int? pkStoreId;
  final String? storeName;
  final String? location;
  final String? tel;
  final bool? kitchen;
  final bool? main;

  Stores({
    required this.pkStoreId,
    required this.storeName,
    required this.location,
    required this.tel,
    required this.kitchen,
    required this.main,
  });

  Stores copyWith({
    int? pkStoreId,
    String? storeName,
    String? location,
    String? tel,
    bool? kitchen,
    bool? main,
  }) {
    return Stores(
      pkStoreId: pkStoreId ?? this.pkStoreId,
      storeName: storeName ?? this.storeName,
      location: location ?? this.location,
      tel: tel ?? this.tel,
      kitchen: kitchen ?? this.kitchen,
      main: main ?? this.main,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pkStoreId': pkStoreId,
      'storeName': storeName,
      'location': location,
      'tel': tel,
      'kitchen': kitchen,
      'main': main,
    };
  }

  factory Stores.fromMap(Map<String, dynamic> map) {
    return Stores(
      pkStoreId: map['pkStoreId'] != null ? map['pkStoreId'] as int : null,
      storeName: map['storeName'] != null ? map['storeName'] as String : null,
      location: map['location'] != null ? map['location'] as String : null,
      tel: map['tel'] != null ? map['tel'] as String : null,
      kitchen: map['kitchen'] != null ? map['kitchen'] as bool : null,
      main: map['main'] != null ? map['main'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Stores.fromJson(String source) =>
      Stores.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Stores(pkStoreId: $pkStoreId, storeName: $storeName, location: $location, tel: $tel, kitchen: $kitchen, main: $main)';
  }

  @override
  bool operator ==(covariant Stores other) {
    if (identical(this, other)) return true;

    return other.pkStoreId == pkStoreId &&
        other.storeName == storeName &&
        other.location == location &&
        other.tel == tel &&
        other.kitchen == kitchen &&
        other.main == main;
  }

  @override
  int get hashCode {
    return pkStoreId.hashCode ^
        storeName.hashCode ^
        location.hashCode ^
        tel.hashCode ^
        kitchen.hashCode ^
        main.hashCode;
  }
}
