import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kmart/const/consts.dart';
import 'package:kmart/controllers/get_device_token.dart';
import 'package:kmart/models/user_model.dart';
import 'package:kmart/views/user_home/home.dart';

import '../const/firebase_const.dart';

class MyGoogleSigninController extends GetxController {
  bool isLoading = false;

  Future<void> signInWithGooglemethod() async {
    final GetDeviceTokenController getDeviceTokenController =
        Get.put(GetDeviceTokenController());
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        // check user credentail is not null

        final UserCredential userCredential =
            await auth.signInWithCredential(credential);

        final User? user = userCredential.user;

        if (user != null) {
          isLoading = true;
          const CircularProgressIndicator();
          UserModel userModel = UserModel(
              uId: user.uid,
              userName: user.displayName.toString(),
              userEmail: user.email.toString(),
              phone: user.phoneNumber.toString(),
              userImg: user.photoURL.toString(),
              userDeviceToken: getDeviceTokenController.deviceToken.toString(),
              country: '',
              userAddress: '',
              city: '',
              street: '',
              isAdmin: false,
              isActive: true,
              createdOn: DateTime.now());

          await FirebaseFirestore.instance
              .collection(usersCollection)
              .doc(user.uid)
              .set(userModel.toMap());
          isLoading = false;
          Get.offAll(() => const Home());
        } else {}
      }
    } catch (e) {
      isLoading = false;
      print("Errorc $e");
    }
  }
}
