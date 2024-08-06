import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:kmart/models/cart_model.dart';
import 'package:kmart/models/product_model.dart';
import 'package:kmart/views/cart/cart_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../const/consts.dart';
import '../../controllers/rating_controller.dart';
import '../../models/review_model.dart';

class ItemDetailsScreen extends StatelessWidget {
  final ProductModel productModel;
  const ItemDetailsScreen({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    CalculateProductRatingController calculateProductRatingController = Get.put(
        CalculateProductRatingController(productId: productModel.productId));

    return WillPopScope(
      onWillPop: () async {
        // pController.resetValues();
        return true;
      },
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                // pController.resetValues();
                Get.back();
              },
              icon: const Icon(Icons.arrow_back)),
          title: Text(
            "",
            // title!,
            style: TextStyle(color: fontGrey, fontFamily: bold),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Get.to(const CartScreen());
                },
                icon: Icon(
                  Icons.shopping_cart,
                  color: darkFontGrey,
                )),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.share,
                  color: darkFontGrey,
                )),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.favorite_border_outlined, color: darkFontGrey),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CarouselSlider(
                          items: List.generate(
                              productModel.productImages.length, (index) {
                            return Image.network(
                              productModel.productImages[0],
                              alignment: Alignment.center,
                              width: double.infinity,
                            );
                          }),
                          options: CarouselOptions(
                            aspectRatio: 16 / 9,
                            viewportFraction: 1.0,
                            height: 350,
                            autoPlay: true,
                            enlargeCenterPage: true,
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        productModel.productName,
                        //title!,
                        style: const TextStyle(
                          fontFamily: bold,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // review
                      Row(
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            child: RatingBar.builder(
                              glow: false,
                              ignoreGestures: true,
                              itemSize: 25,
                              initialRating: double.parse(
                                  calculateProductRatingController.averageRating
                                      .toString()),
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              updateOnDrag: true,
                              itemPadding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                double.parse(""
                                    //data['p_rating']
                                    );

                                // print(rating);
                              },
                            ),
                          ),
                          Text(calculateProductRatingController.averageRating
                              .toString())
                        ],
                      ),

                      SizedBox(
                        height: 10,
                      ),

                      Text(
                        "\$ ${productModel.isSale == true && productModel.salePrice != '' ? productModel.salePrice : productModel.fullPrice}",
                        style: TextStyle(
                            fontFamily: bold, color: redColor, fontSize: 16),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 60,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(color: textfieldGrey),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Seller",
                                    style: TextStyle(
                                        fontFamily: semibold,
                                        color: whiteColor,
                                        fontSize: 10),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text(
                                    "",
                                    // data['p_saller'],
                                    style: TextStyle(
                                        fontFamily: semibold, fontSize: 10),
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                sendMessageOnWhatsapp(
                                    productModel: productModel);
                              },
                              child: CircleAvatar(
                                backgroundColor: whiteColor,
                                child: Icon(
                                  Icons.message_rounded,
                                  color: darkFontGrey,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: whiteColor,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: Text(
                                    "Color: ",
                                    style: TextStyle(color: textfieldGrey),
                                  ),
                                ),
                                Row(
                                  children: List.generate(
                                    3,
                                    //  data['p_colors'].length,
                                    (index) => Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            // pController
                                            //     .changeColorIndx(index);
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 8),
                                            height: 40,
                                            width: 40,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              // color: Color(
                                              //   (data['p_colors'][index]),
                                              // ),
                                            ),
                                          ),
                                        ),
                                        // Visibility(
                                        //   visible: index ==
                                        //       pController.colorIndx.value,
                                        //   child:  Icon(
                                        //     Icons.done,
                                        //     color: Colors.white,
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      /// Description section
                      const SizedBox(
                        height: 10,
                      ),

                      Text(
                        productModel.productDescription,
                        style: TextStyle(
                          fontFamily: semibold,
                          color: darkFontGrey,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      ListView(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: List.generate(
                          5,
                          (index) => ListTile(
                            title: Text(
                              "demo",
                              style: TextStyle(
                                  fontFamily: semibold, color: darkFontGrey),
                            ),
                            trailing: const Icon(Icons.arrow_forward),
                          ),
                        ),
                      ),
                      // Products May You Like

                      const SizedBox(
                        height: 20,
                      ),

                      Text(
                        "Products My You Like",
                        style: TextStyle(
                            fontFamily: bold,
                            color: darkFontGrey,
                            fontSize: 16),
                      ),

                      ///////////////
                      const SizedBox(
                        height: 15,
                      ),

                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                            6,
                            (index) => Container(
                              padding: const EdgeInsets.all(6),
                              margin: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: whiteColor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    imgP1,
                                    width: 145,
                                    fit: BoxFit.cover,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Laptop 4GB/64GB",
                                    style: TextStyle(
                                      fontFamily: semibold,
                                      color: darkFontGrey,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "\$600",
                                    style: TextStyle(
                                        fontFamily: bold,
                                        color: redColor,
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                      //  product review & rating

                      const SizedBox(
                        height: 20,
                      ),

                      Text(
                        "Reviews",
                        style: TextStyle(
                            fontFamily: bold,
                            color: darkFontGrey,
                            fontSize: 16),
                      ),

                      ///////////////
                      const SizedBox(
                        height: 15,
                      ),

                      FutureBuilder(
                          future: FirebaseFirestore.instance
                              .collection('products')
                              .doc(productModel.productId)
                              .collection('reviews')
                              .get(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasError) {
                              return Center(child: Text("Error"));
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Container(
                                child: CupertinoActivityIndicator(),
                              );
                            }

                            if (snapshot.data!.docs.isEmpty) {
                              return Center(child: Text("No review found"));
                            }

                            if (snapshot.data!.docs.isNotEmpty) {
                              return ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: ((context, index) {
                                    var data = snapshot.data!.docs[index];
                                    ReviewModel reviewModel = ReviewModel(
                                      customerName: data['customerName'],
                                      customerPhone: data['customerPhone'],
                                      customerDeviceToken:
                                          data['customerDeviceToken'],
                                      customerId: data['customerId'],
                                      feedback: data['feedback'],
                                      rating: data['rating'],
                                      createdAt: data['createdAt'],
                                    );

                                    return Card(
                                      elevation: 5,
                                      color: whiteColor,
                                      child: ListTile(
                                        leading: CircleAvatar(
                                          child:
                                              Text(reviewModel.customerName[0]),
                                        ),
                                        title: Text(reviewModel.customerName),
                                        subtitle: Text(reviewModel.feedback),
                                        trailing: Text(reviewModel.rating),
                                      ),
                                    );
                                  }));
                            }

                            return SizedBox.shrink();
                          }),

                      const SizedBox(
                        height: 10,
                      ),

                      //////////
                    ],
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                // pController.addToCart(
                //     color: data['p_colors'][pController.colorIndx.value],
                //     context: context,
                //     img: data['p_images'][0],
                //     qty: pController.quantity.value,
                //     sellerName: data['p_saller'],
                //     title: data['p_name'],
                //     tPrice: pController.totaPrice.value);

                // print("data is ${data['p_name'].toString()}");

                await checkProductExistance(uid: user!.uid);

                Get.snackbar("Error", "Added to cart");
                Get.to(() => const CartScreen());
              },
              child: Container(
                margin: const EdgeInsets.all(12.0),
                alignment: Alignment.center,
                height: 50,
                decoration: BoxDecoration(
                    color: redColor, borderRadius: BorderRadius.circular(5)),
                child: Text(
                  "Add To Cart",
                  style: TextStyle(
                      fontFamily: semibold, color: whiteColor, fontSize: 15),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  static Future<void> sendMessageOnWhatsapp(
      {required ProductModel productModel}) async {
    const number = "9719939512";
    final message =
        "Hello Kmart \n i want to know about the product \n ${productModel.productName} \n ${productModel.productId}";
    final url =
        'https://wa.me/ $number ? text= ${Uri.encodeComponent(message)}';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw "Could no launch $url";
    }
  }

  Future<void> checkProductExistance(
      {required String uid, int quantityIncrement = 1}) async {
    final DocumentReference documentReference = FirebaseFirestore.instance
        .collection('cart')
        .doc(uid)
        .collection("cartOrders")
        .doc(productModel.productId.toString());

    DocumentSnapshot snapshot = await documentReference.get();

    if (snapshot.exists) {
      var currentQuantity = snapshot['productQuantity'];
      int updatedQuantity = currentQuantity + quantityIncrement;
      double totalPrice = double.parse(productModel.isSale
              ? productModel.salePrice
              : productModel.fullPrice) *
          updatedQuantity;

      await documentReference.update({
        'productQuantity': updatedQuantity,
        'productTotalPrice': totalPrice
      });
      print("Product exist");
    } else {
      await FirebaseFirestore.instance
          .collection('cart')
          .doc(uid)
          .set({"uId": uid, "createdAt": DateTime.now()});

      CartModel cartModel = CartModel(
        categoryId: productModel.categoryId,
        categoryName: productModel.categoryName,
        deliveryTime: productModel.deliveryTime,
        fullPrice: productModel.fullPrice,
        productDescription: productModel.productDescription,
        productId: productModel.productId,
        productImages: productModel.productImages,
        productName: productModel.productName,
        salePrice: productModel.salePrice,
        updatedAt: DateTime.now(),
        createdAt: DateTime.now(),
        isSale: productModel.isSale,
        productQuantity: 1,
        productTotalPrice: double.parse(productModel.isSale
            ? productModel.salePrice
            : productModel.fullPrice),
      );

      await documentReference.set(cartModel.toMap());

      print("Product added");
    }
  }
}
