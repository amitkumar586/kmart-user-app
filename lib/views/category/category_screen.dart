import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kmart/common_widgets/bg_widget.dart';
import '../../const/colors.dart';
import '../../const/firebase_const.dart';
import '../../const/styles.dart';
import '../../models/category_model.dart';
import 'category_detail.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
          "categories",
          style: TextStyle(fontFamily: bold, color: whiteColor),
        ),
      ),
      body: FutureBuilder(
        future:
            FirebaseFirestore.instance.collection(categoriesCollection).get(),
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
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: data.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      mainAxisExtent: 214),
                  itemBuilder: (context, index) {
                    // productController.getSubCategories(categoriesList[index]);
                    CategoryModel categoryModel = CategoryModel(
                        categoryId: data[index]["categoryId"],
                        categoryImage: data[index]["categoryImage"],
                        categoryName: data[index]["categoryName"],
                        updatedAt: data[index]["updatedAt"],
                        createdAt: data[index]["createdAt"]);
                    return InkWell(
                      onTap: () {
                        print("Index $index");
                        Get.to(() => CategoryDetail(
                            categoryId: categoryModel.categoryId,
                            categoryName: categoryModel.categoryName));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: whiteColor),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(6),
                                topRight: Radius.circular(6),
                              ),
                              child: Image.network(
                                categoryModel.categoryImage[0].toString(),
                                height: Get.height * 0.21,
                                fit: BoxFit.fill,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Expanded(
                              child: Text(
                                categoryModel.categoryName.toString(),
                                style: TextStyle(
                                    color: darkFontGrey,
                                    fontFamily: semibold,
                                    fontSize: 12),
                                textAlign: TextAlign.center,
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            );
          }
          return const SizedBox();

          //////////////////////////////////////////
        },
      ),

      /////////////////////////////////////

      /////////////////////////////////
    ));
  }
}
