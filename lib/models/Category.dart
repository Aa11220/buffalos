// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Category {
  final int pkCategory;
  final String categoryName;

  Category({
    required this.pkCategory,
    required this.categoryName,
  });

  Category copyWith({
    int? pkCategory,
    String? categoryName,
  }) {
    return Category(
      pkCategory: pkCategory ?? this.pkCategory,
      categoryName: categoryName ?? this.categoryName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pkCategory': pkCategory,
      'categoryName': categoryName,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      pkCategory: map['pkCategory'] as int,
      categoryName: map['categoryName'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source) =>
      Category.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Category(pkCategory: $pkCategory, categoryName: $categoryName)';

  @override
  bool operator ==(covariant Category other) {
    if (identical(this, other)) return true;

    return other.pkCategory == pkCategory && other.categoryName == categoryName;
  }

  @override
  int get hashCode => pkCategory.hashCode ^ categoryName.hashCode;
}
