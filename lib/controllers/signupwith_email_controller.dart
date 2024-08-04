import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import 'package:kmart/models/user_model.dart';

import '../const/colors.dart';
import '../const/firebase_const.dart';

class SignupController extends GetxController {
// for password visiblity
  var isPasswordVisible = false.obs;
  RxBool isLoading = false.obs;

  Future<UserCredential?> signup(
    String userName,
    String userEmail,
    String userPhone,
    String userCity,
    String userPassword,
    String userDeviceToken,
  ) async {
    try {
      isLoading.value == true;
      // firstly signup user
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: userEmail, password: userPassword);

      // sent  verification email to user account
      await userCredential.user!.sendEmailVerification();

      // pass data into model

      UserModel userModel = UserModel(
          uId: userCredential.user!.uid,
          userName: userName,
          userEmail: userEmail,
          phone: userPhone,
          userImg: '',
          userDeviceToken: userDeviceToken,
          country: '',
          userAddress: '',
          city: userCity,
          street: '',
          isAdmin: false,
          isActive: true,
          createdOn: DateTime.now());

      // send data into DB

      firestore
          .collection(usersCollection)
          .doc(userCredential.user!.uid)
          .set(userModel.toMap());
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
