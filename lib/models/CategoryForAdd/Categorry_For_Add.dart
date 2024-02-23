// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CategoryForAdd {
  final int pkCategory;
  final String categoryName;
  final Map? fkCategory;
  CategoryForAdd({
    required this.pkCategory,
    required this.categoryName,
    this.fkCategory,
  });

  CategoryForAdd copyWith({
    int? pkCategory,
    String? categoryName,
    Map? fkCategory,
  }) {
    return CategoryForAdd(
      pkCategory: pkCategory ?? this.pkCategory,
      categoryName: categoryName ?? this.categoryName,
      fkCategory: fkCategory ?? this.fkCategory,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pkCategory': pkCategory,
      'categoryName': categoryName,
      'fkCategory': fkCategory,
    };
  }

  factory CategoryForAdd.fromMap(Map<String, dynamic> map) {
    return CategoryForAdd(
      pkCategory: map['pkCategory'] as int,
      categoryName: map['categoryName'] as String,
      fkCategory: map['fkCategory'] != null
          ? map['fkCategory'] as Map<String, dynamic>
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryForAdd.fromJson(String source) =>
      CategoryForAdd.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'CategoryForAdd(pkCategory: $pkCategory, categoryName: $categoryName, fkCategory: $fkCategory)';

  @override
  bool operator ==(covariant CategoryForAdd other) {
    if (identical(this, other)) return true;

    return other.pkCategory == pkCategory &&
        other.categoryName == categoryName &&
        other.fkCategory == fkCategory;
  }

  @override
  int get hashCode =>
      pkCategory.hashCode ^ categoryName.hashCode ^ fkCategory.hashCode;
}
