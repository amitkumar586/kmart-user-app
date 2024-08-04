import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:get/get.dart';
import 'package:kmart/const/consts.dart';
import 'package:kmart/controllers/products_controller.dart';
import 'package:kmart/models/cart_model.dart';
import 'package:kmart/services/get_server_key.dart';
import '../controllers/get_customer_device_token_controller.dart';
import '../services/place_order_service.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final ProductController productController = Get.put(ProductController());
    User? user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        // automaticallyImplyLeading: true,
        title: Text(
          "Checkout Screen",
          style: TextStyle(fontFamily: semibold, color: darkFontGrey),
        ),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('cart')
              .doc(user!.uid)
              .collection('cartOrders')
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
                          CartModel cartModel = CartModel(
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
                                  productData['productTotalPrice']);

                          //calculate price
                          productController.fetchProductPrice();

                          return SwipeActionCell(
                              key: ObjectKey(cartModel.productId),
                              trailingActions: [
                                SwipeAction(
                                    title: "Delete",
                                    forceAlignmentToBoundary: true,
                                    performsFirstActionWithFullSwipe: true,
                                    onTap: (CompletionHandler hanler) async {
                                      await FirebaseFirestore.instance
                                          .collection('cart')
                                          .doc(user.uid)
                                          .collection('cartOrders')
                                          .doc(cartModel.productId)
                                          .delete();
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
                                        cartModel.productImages[0].toString(),
                                      )),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  title: Text(
                                    cartModel.productName,
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
                                          cartModel.productTotalPrice
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: semibold,
                                              color: redColor),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          InkWell(
                                            onTap: () async {
                                              if (cartModel.productQuantity >
                                                  1) {
                                                await FirebaseFirestore.instance
                                                    .collection('cart')
                                                    .doc(user.uid)
                                                    .collection('cartOrders')
                                                    .doc(cartModel.productId)
                                                    .update({
                                                  'productQuantity': cartModel
                                                          .productQuantity -
                                                      1,
                                                  'productTotalPrice': (double
                                                          .parse(cartModel
                                                              .fullPrice) *
                                                      (cartModel
                                                              .productQuantity -
                                                          1))
                                                });
                                              }
                                            },
                                            child: CircleAvatar(
                                              minRadius: 8,
                                              backgroundColor: redColor,
                                              child: Icon(
                                                Icons.remove,
                                                size: 15,
                                                color: whiteColor,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Text(
                                              cartModel.productQuantity
                                                  .toString(),
                                              // pController.quantity.value.toString(),
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: darkFontGrey,
                                                  fontFamily: bold),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              if (cartModel.productQuantity >
                                                  0) {
                                                await FirebaseFirestore.instance
                                                    .collection('cart')
                                                    .doc(user.uid)
                                                    .collection('cartOrders')
                                                    .doc(cartModel.productId)
                                                    .update({
                                                  'productQuantity': cartModel
                                                          .productQuantity +
                                                      1,
                                                  'productTotalPrice': (double
                                                          .parse(cartModel
                                                              .fullPrice) +
                                                      double.parse(cartModel
                                                              .fullPrice) *
                                                          (cartModel
                                                              .productQuantity))
                                                });
                                              }
                                            },
                                            child: CircleAvatar(
                                              minRadius: 8,
                                              backgroundColor: redColor,
                                              child: Icon(
                                                Icons.add,
                                                size: 15,
                                                color: whiteColor,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "3",
                                            // data['p_quantity'],
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: darkFontGrey,
                                                fontFamily: bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ));
                        }),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 5,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 100,
                        child: Text(
                          "Total Price: ",
                          style: TextStyle(color: fontGrey),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Obx(
                        () => Text(
                          productController.totalPrice.value.toStringAsFixed(1),
                          style: TextStyle(
                              fontFamily: bold, color: redColor, fontSize: 16),
                        ),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () async {
                          Get.snackbar("Error", "Added to cart");
                          // showCustomBottomSheet();
                          GetServerKey getServerKey = GetServerKey();
                          String accessToken =
                              await getServerKey.getServerKeyToken();
                          print(accessToken);
                        },
                        child: Container(
                          // margin: const EdgeInsets.all(5.0),
                          alignment: Alignment.center,
                          height: 40,
                          width: 150,
                          decoration: BoxDecoration(
                              color: redColor,
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            "Confirm Order",
                            style: TextStyle(
                                fontFamily: semibold,
                                color: whiteColor,
                                fontSize: 15),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ]);
            }
          }),
    );
  }

  void showCustomBottomSheet() {
    Get.bottomSheet(
      backgroundColor: Colors.transparent,
      isDismissible: true,
      elevation: 6,
      Container(
        height: Get.height,
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(16.0),
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: SizedBox(
                height: 55,
                child: TextFormField(
                  controller: nameController,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                      labelText: "Name",
                      contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                      hintStyle: TextStyle(fontSize: 12)),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: SizedBox(
                height: 55,
                child: TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                      labelText: "Phone",
                      contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                      hintStyle: TextStyle(fontSize: 12)),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: SizedBox(
                height: 55,
                child: TextFormField(
                  controller: addressController,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                      labelText: "Address",
                      contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                      hintStyle: TextStyle(fontSize: 12)),
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                if (nameController.text != '' &&
                    phoneController != '' &&
                    addressController != '') {
                  String name = nameController.text.trim();
                  String phone = phoneController.text.trim();
                  String address = addressController.text.trim();
                  String customerToken = await getCustomerDeviceToken();

                  placeOrderService(
                      context: context,
                      customerName: name,
                      customerPhone: phone,
                      customerAddress: address,
                      customerDeviceToken: customerToken);
                } else {
                  print('please fill all details');
                }
              },
              child: Container(
                // margin: const EdgeInsets.all(5.0),
                alignment: Alignment.center,
                height: 40,
                width: 150,
                decoration: BoxDecoration(
                    color: redColor, borderRadius: BorderRadius.circular(5)),
                child: Text(
                  "Place Order",
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
}
