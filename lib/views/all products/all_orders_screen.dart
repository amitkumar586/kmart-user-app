import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:get/get.dart';
import 'package:kmart/const/consts.dart';
import 'package:kmart/controllers/products_controller.dart';
import '../../models/order_model.dart';
import '../../review/add_review_screen.dart';

class AllOrdersScreen extends StatefulWidget {
  const AllOrdersScreen({super.key});

  @override
  State<AllOrdersScreen> createState() => _AllOrdersScreenState();
}

class _AllOrdersScreenState extends State<AllOrdersScreen> {
  @override
  Widget build(BuildContext context) {
    final ProductController productController = Get.put(ProductController());
    User? user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        // automaticallyImplyLeading: true,
        title: Text(
          "All Orders",
          style: TextStyle(fontFamily: semibold, color: darkFontGrey),
        ),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('orders')
              .doc(user!.uid)
              .collection('confirmOrders')
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text("Error"),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Column(children: [
                Expanded(
                  child: Container(
                    // color: Colors.red,
                    child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, index) {
                          final productData = snapshot.data!.docs[index];
                          OrderModel orderModel = OrderModel(
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
                              productQuantity: productData['productQuantity'],
                              productTotalPrice:
                                  productData['productTotalPrice'],
                              customerId: productData['customerId'],
                              status: productData['status'],
                              customerName: productData['customerName'],
                              customerPhone: productData['customerPhone'],
                              customerAddress: productData['customerAddress'],
                              customerDeviceToken:
                                  productData['customerDeviceToken']);

                          //calculate price
                          productController.fetchProductPrice();

                          return SwipeActionCell(
                              key: ObjectKey(orderModel.productId),
                              trailingActions: [
                                SwipeAction(
                                    title: "Delete",
                                    forceAlignmentToBoundary: true,
                                    performsFirstActionWithFullSwipe: true,
                                    onTap: (CompletionHandler hanler) async {
                                      print('deleted');
                                      // await FirebaseFirestore.instance
                                      //     .collection('cart')
                                      //     .doc(user.uid)
                                      //     .collection('cartOrders')
                                      //     .doc(cartModel.productId)
                                      //     .delete();
                                    })
                              ],
                              child: Card(
                                child: ListTile(
                                    leading: Container(
                                      height: 50,
                                      width: 60,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                          orderModel.productImages[0]
                                              .toString(),
                                        )),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    title: Text(
                                      orderModel.productName,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: semibold,
                                          color: darkFontGrey),
                                    ),
                                    subtitle: Row(
                                      children: [
                                        SizedBox(
                                          width: 100,
                                          child: Text(
                                            orderModel.productTotalPrice
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontFamily: semibold,
                                                color: redColor),
                                          ),
                                        ),
                                        orderModel.status != true
                                            ? Text(
                                                "Pending...",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontFamily: semibold,
                                                    color: Colors.green),
                                              )
                                            : Text(
                                                "Delivered",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontFamily: semibold,
                                                    color: redColor),
                                              )
                                      ],
                                    ),
                                    trailing:
                                        //orderModel.status == true?
                                        ElevatedButton(
                                            onPressed: () {
                                              Get.to(() => AddReviewScreen(
                                                  orderModel: orderModel));
                                            },
                                            child: Text(
                                              "Review",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontFamily: semibold,
                                                  color: redColor),
                                            ))
                                    // : SizedBox.shrink(),
                                    ),
                              ));
                        }),
                  ),
                ),
                // Container(
                //   padding: const EdgeInsets.all(8),
                //   decoration: BoxDecoration(
                //     color: whiteColor,
                //     boxShadow: [
                //       BoxShadow(
                //         color: Colors.grey.withOpacity(0.5),
                //         blurRadius: 5,
                //         offset: const Offset(0, 4),
                //       ),
                //     ],
                //   ),
                //   child: Row(
                //     children: [
                //       SizedBox(
                //         width: 100,
                //         child: Text(
                //           "Total Price: ",
                //           style: TextStyle(color: fontGrey),
                //         ),
                //       ),
                //       const SizedBox(
                //         width: 10,
                //       ),
                //       Obx(
                //         () => Text(
                //           productController.totalPrice.value.toStringAsFixed(1),
                //           style: TextStyle(
                //               fontFamily: bold, color: redColor, fontSize: 16),
                //         ),
                //       ),
                //       const Spacer(),
                //       InkWell(
                //         onTap: () {
                //           Get.snackbar("Error", "Added to cart");
                //           // Get.to(() => const CartScreen());
                //           Get.to(() => const CheckoutScreen());
                //         },
                //         child: Container(
                //           // margin: const EdgeInsets.all(5.0),
                //           alignment: Alignment.center,
                //           height: 40,
                //           width: 150,
                //           decoration: BoxDecoration(
                //               color: redColor,
                //               borderRadius: BorderRadius.circular(5)),
                //           child: Text(
                //             "Checkout",
                //             style: TextStyle(
                //                 fontFamily: semibold,
                //                 color: whiteColor,
                //                 fontSize: 15),
                //           ),
                //         ),
                //       )
                //     ],
                //   ),
                // ),
              ]);
            }
          }),
    );
  }
}
