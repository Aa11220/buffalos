import '../../../apis/categoriesapi.dart';

class catcoontroller {
  final CategoriesApi categoriesapi;

  catcoontroller({required this.categoriesapi});

  getCategories() async {
    final mylist = await categoriesapi.fetchCategories();
    return mylist;
  }
}
