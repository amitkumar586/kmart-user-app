import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../const/colors.dart';
import '../../const/firebase_const.dart';
import '../../const/styles.dart';
import '../../models/product_model.dart';
import '../category/item_details.dart';

class AllProducts extends StatefulWidget {
  const AllProducts({super.key});

  @override
  State<AllProducts> createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection(productsCollection)
          .where("isSale", isEqualTo: false)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          print('data ${!snapshot.hasData}');
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.data!.docs.isEmpty) {
          return Center(
            child: Text(
              "Empty",
              style: TextStyle(fontFamily: semibold, color: darkFontGrey),
            ),
          );
        } else if (snapshot.hasError) {
          Center(
            child: Text(
              "Error",
              style: TextStyle(fontFamily: bold, color: whiteColor),
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          const Center(child: CircularProgressIndicator());
        } else if (snapshot.data!.docs.isNotEmpty) {
          var data = snapshot.data!.docs;
          return Container(
            padding: const EdgeInsets.all(5),
            child: Expanded(
              child: GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: data.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      mainAxisExtent: 250),
                  itemBuilder: (context, index) {
                    final productData = snapshot.data!.docs[index];
                    ProductModel productModel = ProductModel(
                      categoryId: productData['categoryId'],
                      categoryName: productData['categoryName'],
                      deliveryTime: productData['deliveryTime'],
                      fullPrice: productData['fullPrice'],
                      productDescription: productData['productDescription'],
                      productId: productData['productId'],
                      productImages: productData['productImages'],
                      productName: productData['productName'],
                      salePrice: productData['salePrice'],
                      updatedAt: productData['updatedAt'],
                      createdAt: productData['createdAt'],
                      isSale: productData['isSale'],
                      // p_vender_id: data[index]["p_vender_id"],
                      // p_colors: data[index]["p_colors"],
                      // p_quantity: data[index]["p_quantity"],
                      // p_seller: data[index]["p_seller"],
                      // p_rating: data[index]["p_rating"],
                      // p_wishlist: data[index]["p_wishlist"]
                    );

                    print(productModel);
                    return InkWell(
                      onTap: () {
                        Get.to(() => ItemDetailsScreen(
                              productModel: productModel,
                            ));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: whiteColor),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 5),
                          decoration: BoxDecoration(
                              color: whiteColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(
                                productModel.productImages[0],
                                width: 200,
                                height: 180,
                                fit: BoxFit.cover,
                              ),
                              const Spacer(),
                              Text(
                                productModel.productName,
                                style: TextStyle(
                                  fontFamily: semibold,
                                  color: darkFontGrey,
                                ),
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Text(
                                "\$ ${productModel.fullPrice.toString()}",
                                style: TextStyle(
                                    fontFamily: bold,
                                    color: redColor,
                                    fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          );
        }
        return const SizedBox();
        //////////////////////////////////////////
      },
    );
  }
}
