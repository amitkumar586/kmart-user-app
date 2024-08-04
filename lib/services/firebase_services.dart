import 'package:cloud_firestore/cloud_firestore.dart';

import '../const/firebase_const.dart';

class FirebaseServices {
  static getProducts(categoryId) {
    FirebaseFirestore.instance
        .collection(productsCollection)
        .where("", isEqualTo: categoryId)
      .snapshots();

    //     static getProducts(categoryId) {
    // FirebaseFirestore.instance
    //     .collection(productsCollection)
    //     .where("", isEqualTo: categoryId)
    //     .snapshots();
    // return firestore
    //     .collection(productsCollection)
    //     .where("p_category", isEqualTo: category)
    //     .snapshots();
  }

  static getCart(uid) {
    firestore
        .collection(cartCollection)
        .where("addedBy", isEqualTo: uid)
        .snapshots();
  }
}
