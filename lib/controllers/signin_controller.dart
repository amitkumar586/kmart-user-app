import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../const/colors.dart';
import '../const/firebase_const.dart';

class SigninController extends GetxController {
  // for password visiblity
  var isPasswordVisible = false.obs;
  RxBool isLoading = false.obs;

  Future<UserCredential?> signin(
    String userEmail,
    String userPassword,
  ) async {
    try {
      isLoading.value == true;
      // firstly signup user
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: userEmail, password: userPassword);

      // send data into DB

      isLoading.value == false;
      return userCredential;
    } on FirebaseAuthException catch (e) {
      isLoading.value == false;
      Get.snackbar("Error", "$e",
          snackPosition: SnackPosition.BOTTOM, backgroundColor: textfieldGrey);
    }
    return null;
  }
}
