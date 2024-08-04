import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:kmart/views/auth/login_screen.dart';
import '../../common_widgets/applogo_widget.dart';
import '../../common_widgets/bg_widget.dart';
import '../../common_widgets/common_text_widget.dart';
import '../../common_widgets/custom_button.dart';
import '../../common_widgets/custom_textfield.dart';
import '../../const/consts.dart';
import '../../controllers/signupwith_email_controller.dart';
import '../../services/notification_service.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  SignupController signupController = Get.put(SignupController());

  final _userNameController = TextEditingController();
  final _userEmailController = TextEditingController();
  final _userPhonecontroller = TextEditingController();
  final _userCityController = TextEditingController();
  final _userPasswordController = TextEditingController();

  bool? isCheck = false;

  @override
  Widget build(BuildContext context) {
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
                        title: 'Name',
                        hintText: 'Enter Name',
                        controller: _userNameController),
                    CustomTextField(
                        title: 'Email',
                        hintText: 'Enter Email',
                        controller: _userEmailController),
                    CustomTextField(
                      title: 'Phone',
                      hintText: 'Enter Phone',
                      controller: _userPhonecontroller,
                    ),
                    Obx(
                      () => CustomTextField(
                        title: 'Password',
                        hintText: 'Enter Password',
                        isObscureText: signupController.isPasswordVisible.value,
                        controller: _userPasswordController,
                        suffixIcon: GestureDetector(
                            onTap: () {
                              signupController.isPasswordVisible.toggle();
                            },
                            child: signupController.isPasswordVisible.value
                                ? const Icon(Icons.visibility_off)
                                : const Icon(Icons.visibility)),
                      ),
                    ),
                    CustomTextField(
                        title: 'City',
                        hintText: 'City',
                        controller: _userCityController),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text("Forget Pasword"),
                      ),
                    ),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Checkbox(
                          checkColor: redColor,
                          value: isCheck,
                          onChanged: (newValue) {
                            setState(() {
                              isCheck = newValue;
                            });
                          },
                        ),
                        const SizedBox(
                          width: 1,
                        ),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'i agree to the',
                                  style: TextStyle(
                                      fontFamily: regular, color: fontGrey),
                                ),
                                TextSpan(
                                  text: termsCondition,
                                  style: TextStyle(
                                      fontFamily: regular, color: redColor),
                                ),
                                TextSpan(
                                  text: '&',
                                  style: TextStyle(
                                      fontFamily: regular, color: redColor),
                                ),
                                TextSpan(
                                  text: privacyPolicy,
                                  style: TextStyle(
                                      fontFamily: regular, color: redColor),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    CustomButton(
                      btnColor: isCheck == true ? redColor : lightGrey,
                      color: whiteColor,
                      title: "Sign up",
                      onTap: () async {
                        NotoficationService notoficationService =
                            NotoficationService();
                        String name = _userNameController.text.trim();
                        String email = _userEmailController.text.trim();
                        String phone = _userPhonecontroller.text.trim();
                        String city = _userCityController.text.trim();
                        String password = _userPasswordController.text.trim();
                        String userDevicetoken =
                            await notoficationService.getDeviceToken();

                        if (name.isEmpty ||
                            email.isEmpty ||
                            phone.isEmpty ||
                            city.isEmpty ||
                            password.isEmpty) {
                          Get.snackbar("Error", "Please Enter all details");
                        } else {
                          UserCredential? userCredential =
                              await signupController.signup(name, email, phone,
                                  city, password, userDevicetoken);

                          if (userCredential != null) {
                            Get.snackbar("verification email sent",
                                "Please check email");

                            FirebaseAuth.instance.signOut();
                            Get.offAll(() => const LoginScreen());
                          }
                        }
                      },
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        commonTextMethod(
                            color: fontGrey,
                            nameTitle: "Already have an account ?",
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold),
                        TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: const Text("Login"),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
    }));
  }
}
