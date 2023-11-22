class ClassName {
  static final List<String> citys = List.generate(20, (index) => "me $index");
  static List<String> getsuggest(String querry) {
    return List.of(citys).where((city) {
      final citylower = city.toLowerCase();
      final querylower = querry.toLowerCase();
      return citylower.contains(querylower);
    }).toList();
  }
}
