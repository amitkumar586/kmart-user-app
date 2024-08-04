import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  RxDouble totalPrice = 0.0.obs;
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void onInit() {
    fetchProductPrice();

    super.onInit();
  }

  Future<void> fetchProductPrice() async {
    final QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('cart')
        .doc(user!.uid)
        .collection('cartOrders')
        .get();

    double sum = 0.0;

    for (final doc in snapshot.docs) {
      final data = doc.data();

      if (data != "" && data.containsKey('productTotalPrice')) {
        sum += (data['productTotalPrice'] as num).toDouble();
      }
    }

    totalPrice.value = sum;
  }
} 



// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:kmart/models/category_model.dart';

// import '..//s.dart';

// class ProductController extends GetxController {
//   var subCat = [];
//   dynamic dataMap;
//   var quantity = 0.obs;
//   var colorIndx = 0.obs;
//   var totaPrice = 0.obs;

//   Future getCategories() async {
//     return await FirebaseFirestore.instance
//         .collection(categoriesCollection)
//         .get();
//   }

//   Future getSubCategories(title) async {
//     subCat.clear();
//     var data = await rootBundle.loadString('lib/services/category_model.json');

//     var decodedData = categoryModelFromJson(data);

//     var s = decodedData.categories
//         .where((element) => element.name == title)
//         .toList();

//     for (var e in s[0].subcategory) {
//       subCat.add(e);
//     }
//   }

//   changeColorIndx(index) {
//     colorIndx.value = index;
//   }

//   increaseQuantity(totalQuantity) {
//     if (quantity.value < totalQuantity) {
//       quantity.value++;
//     }
//   }

//   decreaseQuantity() {
//     if (quantity.value > 0) {
//       quantity.value--;
//     }
//   }

//   calculateTotalPrice(price) {
//     totaPrice.value = price * quantity.value;
//   }

//   addToCart(
//       {addedBy, title, img, sellerName, qty, color, tPrice, context}) async {
//     await firestore.collection(cartCollection).doc().set({
//       "title": title,
//       "img": img,
//       "sellerName": sellerName,
//       "qty": qty,
//       "color": color,
//       "tPrice": tPrice,
//       "addedBy": currenetUser!.uid,
//     }).catchError((error) {
//       Get.snackbar("Error", error.toString());
//     });
//   }

//   resetValues() {
//     totaPrice.value = 0;
//     quantity.value = 0;
//     colorIndx.value = 0;
//   }
// }
