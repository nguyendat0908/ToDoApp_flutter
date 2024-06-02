class CategoryModel {
  String id;
  String name;
  int? iconCodePoint;
  String? backgroundColorHex;
  String? iconColorColorHex;

  CategoryModel(
      {required this.id,
      required this.name,
      this.iconCodePoint,
      this.backgroundColorHex,
      this.iconColorColorHex});
}
