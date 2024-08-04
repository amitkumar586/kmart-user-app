class OrderModel {
  final String categoryId;
  final String categoryName;
  final String deliveryTime;
  final String fullPrice;
  final String productDescription;
  final String productId;
  final List productImages;
  final String productName;
  final String salePrice;
  final dynamic updatedAt;
  final dynamic createdAt;
  final bool isSale;
  final int productQuantity;
  final double productTotalPrice;
  final String customerId;
  final bool status;
  final String customerName;
  final String customerPhone;
  final String customerAddress;
  final String customerDeviceToken;

  OrderModel(
      {required this.categoryId,
      required this.categoryName,
      required this.deliveryTime,
      required this.fullPrice,
      required this.productDescription,
      required this.productId,
      required this.productImages,
      required this.productName,
      required this.salePrice,
      required this.updatedAt,
      required this.createdAt,
      required this.isSale,
      required this.productQuantity,
      required this.productTotalPrice,
      required this.customerId,
      required this.status,
      required this.customerName,
      required this.customerPhone,
      required this.customerAddress,
      required this.customerDeviceToken});

  Map<String, dynamic> toMap() {
    return {
      "categoryId": categoryId,
      "categoryName": categoryName,
      "deliveryTime": deliveryTime,
      "fullPrice": fullPrice,
      "productDescription": productDescription,
      "productId": productId,
      "productImages": productImages,
      "productName": productName,
      "salePrice": salePrice,
      "updatedAt": updatedAt,
      "createdAt": createdAt,
      "isSale": isSale,
      "productQuantity": productQuantity,
      "productTotalPrice": productTotalPrice,
      "customerId": customerId,
      "status": status,
      "customerName": customerName,
      "customerPhone": customerPhone,
      "customerAddress": customerAddress,
      "customerDeviceToken": customerDeviceToken
    };
  }

  factory OrderModel.formMap(Map<String, dynamic> json) {
    return OrderModel(
        categoryId: json["categoryId"],
        categoryName: json["categoryName"],
        deliveryTime: json["deliveryTime"],
        fullPrice: json["fullPrice"],
        productDescription: json["productDescription"],
        productId: json["productId"],
        productImages: json["productImages"],
        productName: json["productName"],
        salePrice: json["salePrice"],
        updatedAt: json["updatedAt"],
        createdAt: json["createdAt"],
        isSale: json["isSale"],
        productQuantity: json["productQuantity"],
        productTotalPrice: json["productTotalPrice"],
        customerId: json["customerId"],
        status: json["status"],
        customerName: json["customerName"],
        customerPhone: json["customerPhone"],
        customerAddress: json["customerAddress"],
        customerDeviceToken: json["customerDeviceToken"]);
  }
}
