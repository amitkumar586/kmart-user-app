import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:kmart/common_widgets/applogo_widget.dart';
import 'package:kmart/common_widgets/bg_widget.dart';
import 'package:kmart/common_widgets/common_text_widget.dart';
import 'package:kmart/controllers/google_signin_controller.dart';
import 'package:kmart/controllers/signin_controller.dart';
import 'package:kmart/views/auth/forget_password_screen.dart';
import 'package:kmart/views/auth/signup.dart';
import '../../common_widgets/custom_button.dart';
import '../../common_widgets/custom_textfield.dart';
import '../../const/consts.dart';
import '../user_home/home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final signinController = Get.put(SigninController());
  final _userEmailController = TextEditingController();
  final _userPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    MyGoogleSigninController googleSigninController =
        Get.put(MyGoogleSigninController());

    return bgWidget(
      child: KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Center(
            child: Column(
              children: [
                SizedBox(
                  height: Get.height * 0.08,
                ),
                appLogoWidget(),
                commonTextMethod(
                    color: Colors.white,
                    nameTitle: "Log in to $appname",
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold),
                Container(
                  width: Get.width * 0.7,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      boxShadow: [BoxShadow(color: darkFontGrey)],
                      color: whiteColor,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12.0),
                          topRight: Radius.circular(12.0))),
                  child: Column(
                    children: [
                      CustomTextField(
                          title: 'Email',
                          hintText: 'Enter Email',
                          controller: _userEmailController),
                      Obx(
                        () => CustomTextField(
                          title: 'Password',
                          hintText: 'Enter Password',
                          isObscureText:
                              signinController.isPasswordVisible.value,
                          controller: _userPasswordController,
                          suffixIcon: InkWell(
                              onTap: () {
                                signinController.isPasswordVisible.toggle();
                              },
                              child: signinController.isPasswordVisible.value
                                  ? const Icon(Icons.visibility_off)
                                  : const Icon(Icons.visibility)),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            Get.offAll(() => const ForgetPasswordScreen());
                          },
                          child: const Text("Forget Pasword"),
                        ),
                      ),
                      CustomButton(
                        btnColor: redColor,
                        color: whiteColor,
                        title: "Login",
                        onTap: () async {
                          String email = _userEmailController.text.trim();
                          String password = _userPasswordController.text.trim();

                          if (email.isEmpty || password.isEmpty) {
                            Get.snackbar("Error", "Please Enter all details");
                          } else {
                            UserCredential? userCredential =
                                await signinController.signin(email, password);

                            if (userCredential != null) {
                              if (userCredential.user!.emailVerified) {
                                Get.snackbar("Error", "Login  Susseccfully");
                                Get.offAll(() => const Home());
                              } else {
                                Get.snackbar("Error",
                                    "Please verify your email before login");
                              }
                            } else {
                              Get.snackbar("Message", "Try Again");
                            }
                          }
                        },
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      commonTextMethod(
                          color: fontGrey,
                          nameTitle: "or create a new account",
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold),
                      const SizedBox(
                        height: 5,
                      ),
                      CustomButton(
                        btnColor: redColor,
                        color: whiteColor,
                        title: "Sign up",
                        onTap: () {
                          Get.to(const SignupScreen());
                        },
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      commonTextMethod(
                          color: fontGrey,
                          nameTitle: "Login with",
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Padding(
                          //   padding:  EdgeInsets.all(8.0),
                          //   child: CircleAvatar(
                          //     radius: 25,
                          //     child: Image.asset(
                          //       icFacebookLogo,
                          //       width: 30,
                          //     ),
                          //   ),
                          // ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                googleSigninController.signInWithGooglemethod();
                              },
                              child: CircleAvatar(
                                radius: 25,
                                child: Image.asset(
                                  icGoogleLogo,
                                  // color: whiteColor,
                                  width: 30,
                                ),
                              ),
                            ),
                          ),
                          // Padding(
                          //   padding:  EdgeInsets.all(8.0),
                          //   child: InkWell(
                          //     onTap: () {
                          //       Get.offAll(() =>  Home());
                          //     },
                          //     child: CircleAvatar(
                          //       radius: 25,
                          //       child: Image.asset(
                          //         icTwitterLogo,
                          //         width: 30,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
