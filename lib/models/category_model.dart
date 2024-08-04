class CategoryModel {
  final String categoryId;
  final List categoryImage;
  final String categoryName;
  final dynamic updatedAt;
  final dynamic createdAt;

  CategoryModel(
      {required this.categoryId,
      required this.categoryImage,
      required this.categoryName,
      required this.updatedAt,
      required this.createdAt});

  Map<String, dynamic> toMap() {
    return {
      "categoryId": categoryId,
      "categoryImage": categoryImage,
      "categoryName": categoryName,
      "updatedAt": updatedAt,
      "createdAt": createdAt
    };
  }

  factory CategoryModel.dromMap(Map<String, dynamic> json) {
    return CategoryModel(
        categoryId: json["categoryId"],
        categoryImage: json["categoryImage"],
        categoryName: json["categoryName"],
        updatedAt: json["updatedAt"],
        createdAt: json["createdAt"]);
  }
}
