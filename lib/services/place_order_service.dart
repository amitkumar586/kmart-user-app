import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:kmart/models/order_model.dart';
import 'package:kmart/services/generate_order_id_service.dart';

import '../const/consts.dart';
import '../views/user_home/home.dart';

void placeOrderService(
    {required BuildContext context,
    required String customerName,
    required String customerPhone,
    required String customerAddress,
    required String customerDeviceToken}) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('cart')
          .doc(user.uid)
          .collection('cartOrders')
          .get();

      List<QueryDocumentSnapshot> documents = querySnapshot.docs;

      for (var doc in documents) {
        Map<String, dynamic>? data = doc.data() as Map<String, dynamic>;

        String orderId = generateOrderId();

        OrderModel orderModel = OrderModel(
          categoryId: data['categoryId'],
          categoryName: data['categoryName'],
          deliveryTime: data['deliveryTime'],
          fullPrice: data['fullPrice'],
          productDescription: data['productDescription'],
          productId: data['productId'],
          productImages: data['productImages'],
          productName: data['productName'],
          salePrice: data['salePrice'],
          updatedAt: DateTime.now(),
          createdAt: DateTime.now(),
          isSale: data['isSale'],
          productQuantity: data['productQuantity'],
          productTotalPrice: data['productTotalPrice'],
          customerId: user.uid,
          status: false,
          customerName: customerName,
          customerPhone: customerPhone,
          customerAddress: customerAddress,
          customerDeviceToken: customerDeviceToken,
        );

        for (var i = 0; i < documents.length; i++) {
          await FirebaseFirestore.instance
              .collection('orders')
              .doc(user.uid)
              .set({
            "uId": user.uid,
            "customerName": customerName,
            "customerPhone": customerPhone,
            "customerAddress": customerAddress,
            "customerDeviceToken": customerDeviceToken,
            "orderStatus": false,
            "updatedAt": DateTime.now(),
            "createdAt": DateTime.now(),
          });

          // upload orders

          await FirebaseFirestore.instance
              .collection('orders')
              .doc(user.uid)
              .collection('confirmOrders')
              .doc(orderId)
              .set(orderModel.toMap());

          // delete cart products

          await FirebaseFirestore.instance
              .collection('cart')
              .doc(user.uid)
              .collection('cartOrders')
              .doc(orderModel.productId.toString())
              .delete()
              .then((value) => print(
                  'Delete cart products ${orderModel.productId.toString()}'));
        }
      }
      print("order Confirm");
      Get.snackbar(
        "order confirmed",
        "Thank you for your order",
        backgroundColor: redColor,
        colorText: whiteColor,
        duration: const Duration(seconds: 5),
      );
      Get.offAll(() => const Home());
    } catch (e) {
      print(e);
    }
  }
}
