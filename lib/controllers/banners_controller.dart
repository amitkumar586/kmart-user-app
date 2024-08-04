import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class BannerController extends GetxController {
  RxList<String> bannersList = RxList<String>([]);

  @override
  void onInit() {
    super.onInit();

    fetchBannersUrls();
  }

  Future<void> fetchBannersUrls() async {
    try {
      QuerySnapshot bannersSnap =
          await FirebaseFirestore.instance.collection('banners').get();

      if (bannersSnap.docs.isNotEmpty) {
        bannersList.value =
            bannersSnap.docs.map((doc) => doc['imageUrl'].toString()).toList();
      }
    } catch (e) {
      print(e);
    }
  }
}
