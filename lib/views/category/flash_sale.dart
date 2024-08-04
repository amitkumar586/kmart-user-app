import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../const/colors.dart';
import '../../const/firebase_const.dart';
import '../../const/styles.dart';
import '../../models/product_model.dart';

class FlashSale extends StatefulWidget {
  const FlashSale({
    super.key,
  });

  @override
  State<FlashSale> createState() => _FlashSaleState();
}

class _FlashSaleState extends State<FlashSale> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Flash Sale",
          style: TextStyle(fontFamily: bold, color: whiteColor),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(productsCollection)
            .where("isSale", isEqualTo: true)
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
              child: Column(
                children: [
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                        data.length,
                        (index) => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          width: 120,
                          height: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: data.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 8,
                                crossAxisSpacing: 8,
                                mainAxisExtent: 230),
                        itemBuilder: (context, index) {
                          final productData = snapshot.data!.docs[index];
                          ProductModel productModel = ProductModel(
                            categoryId: productData['categoryId'],
                            categoryName: productData['categoryName'],
                            deliveryTime: productData['deliveryTime'],
                            fullPrice: productData['fullPrice'],
                            productDescription:
                                productData['productDescription'],
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
                              // print("Index ${index}");
                              // Get.to(() => CategoryDetail(
                              //     categoryId: categoryModel.categoryId));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: whiteColor),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: whiteColor,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10)),
                                      child: Image.network(
                                        productModel.productImages[0],
                                        width: 200,
                                        height: 180,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      productModel.productName,
                                      style: TextStyle(
                                        fontFamily: semibold,
                                        color: darkFontGrey,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
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

                            //  Container(
                            //   padding: EdgeInsets.symmetric(vertical: 5),
                            //   decoration: BoxDecoration(
                            //       borderRadius: BorderRadius.circular(10),
                            //       color: whiteColor),
                            //   child: Column(
                            //     children: [
                            //       ClipRRect(
                            //         borderRadius: BorderRadius.only(
                            //           topLeft: Radius.circular(6),
                            //           topRight: Radius.circular(6),
                            //         ),
                            //         child: Image.network(
                            //           productModel.productImages,
                            //           height: Get.height * 0.20,
                            //           fit: BoxFit.fill,
                            //         ),
                            //       ),
                            //       SizedBox(
                            //         height: 5,
                            //       ),
                            //       Text(
                            //         productModel.productName.toString(),
                            //         overflow: TextOverflow.ellipsis,
                            //         style:  TextStyle(
                            //             color: darkFontGrey,
                            //             fontFamily: semibold,
                            //             fontSize: 12),
                            //         textAlign: TextAlign.center,
                            //       ),
                            //       Text(
                            //         "\$ ${productModel.fullPrice.toString()}",
                            //         style:  TextStyle(
                            //             fontFamily: bold,
                            //             color: redColor,
                            //             fontSize: 16),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                          );
                        }),
                  ),
                ],
              ),
            );
          }
          return const SizedBox();
          //////////////////////////////////////////
        },
      ),
    );
  }
}
