import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:kmart/views/auth/login_screen.dart';

import '../const/colors.dart';
import '../const/firebase_const.dart';

class ForgetPasswordController extends GetxController {
  RxBool isLoading = false.obs;

  Future<void> forgetPassword(
    String userEmail,
  ) async {
    try {
      isLoading.value == true;
      // firstly signup user

      await auth.sendPasswordResetEmail(email: userEmail);

      Get.snackbar("Request Sent Successfully",
          "Password  Reset link sent to $userEmail",
          snackPosition: SnackPosition.BOTTOM, backgroundColor: textfieldGrey);
      Get.to(() => const LoginScreen());

      // send data into DB

      isLoading.value == false;
    } on FirebaseAuthException catch (e) {
      isLoading.value == false;
      Get.snackbar("Error", "$e",
          snackPosition: SnackPosition.BOTTOM, backgroundColor: textfieldGrey);
    }
  }
}
