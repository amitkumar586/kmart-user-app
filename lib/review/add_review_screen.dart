import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:kmart/const/consts.dart';
import 'package:kmart/models/order_model.dart';

import '../models/review_model.dart';

class AddReviewScreen extends StatefulWidget {
  final OrderModel orderModel;
  const AddReviewScreen({super.key, required this.orderModel});

  @override
  State<AddReviewScreen> createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends State<AddReviewScreen> {
  TextEditingController feedbackController = TextEditingController();
  double productRating = 0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        // automaticallyImplyLeading: true,
        title: Text(
          "Add Reviews",
          style: TextStyle(fontFamily: semibold, color: darkFontGrey),
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Add your Rating & Review",
              style: TextStyle(fontFamily: semibold, color: darkFontGrey),
            ),
            RatingBar.builder(
              initialRating: 0,
              maxRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.1),
              itemBuilder: (context, _) {
                return Icon(
                  Icons.star,
                  color: Colors.yellow,
                );
              },
              onRatingUpdate: (rating) {
                productRating = rating;
                print(productRating);
                setState(() {});
              },
            ),
            Text(
              "Feedback",
              style: TextStyle(fontFamily: semibold, color: darkFontGrey),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: SizedBox(
                height: 55,
                child: TextFormField(
                  controller: feedbackController,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                      labelText: "Share your feedback",
                      contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                      hintStyle: TextStyle(fontSize: 12)),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                String feedback = feedbackController.text.trim();
                print(feedback);
                print(productRating);
                ReviewModel reviewModel = ReviewModel(
                    customerName: widget.orderModel.customerName,
                    customerPhone: widget.orderModel.customerPhone,
                    customerDeviceToken: widget.orderModel.customerDeviceToken,
                    customerId: widget.orderModel.customerId,
                    feedback: feedback,
                    rating: productRating.toString(),
                    createdAt: DateTime.now());

                await FirebaseFirestore.instance
                    .collection('products')
                    .doc(widget.orderModel.productId)
                    .collection('reviews')
                    .doc(widget.orderModel.customerId)
                    .set(reviewModel.toMap());
              },
              child: Text(
                "Save",
                style: TextStyle(fontFamily: semibold, color: darkFontGrey),
              ),
            )
          ],
        ),
      ),
    );
  }
}
