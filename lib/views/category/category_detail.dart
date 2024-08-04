import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:kmart/common_widgets/bg_widget.dart';

import 'package:kmart/models/product_model.dart';

import '../../const/consts.dart';
import '../../const/firebase_const.dart';
import 'item_details.dart';

class CategoryDetail extends StatefulWidget {
  final String categoryId;
  final String categoryName;
  const CategoryDetail(
      {super.key, required this.categoryId, required this.categoryName});

  @override
  State<CategoryDetail> createState() => _CatedoryDetailState();
}

class _CatedoryDetailState extends State<CategoryDetail> {
  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.categoryName,
            style: TextStyle(fontFamily: bold, color: whiteColor),
          ),
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection(productsCollection)
              .where("categoryId", isEqualTo: widget.categoryId)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                // padding:  EdgeInsets.all(5),
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
                                  mainAxisExtent: 260),
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
                                isSale: productData['isSale']);

                            print(productModel);
                            return InkWell(
                              onTap: () {
                                Get.to(ItemDetailsScreen(
                                    productModel: productModel));

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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10)),
                                        child: Image.network(
                                          productModel.productImages[0],
                                          width: 200,
                                          height: 204,
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
      ),
    );
  }
}
