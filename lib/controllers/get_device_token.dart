import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:kmart/const/colors.dart';

class GetDeviceTokenController extends GetxController {
  String? deviceToken;

  @override
  void onInit() {
    super.onInit();

    getDeviceToken();
  }

  Future<void> getDeviceToken() async {
    try {
      String? token = await FirebaseMessaging.instance.getToken();

      if (token != '') {
        deviceToken = token;
        update();
      }
    } catch (e) {
      Get.snackbar("Error", " $e",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: redColor,
          colorText: whiteColor);
    }
  }
}
