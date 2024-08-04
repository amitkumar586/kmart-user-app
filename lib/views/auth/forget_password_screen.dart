import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:kmart/common_widgets/applogo_widget.dart';
import 'package:kmart/common_widgets/bg_widget.dart';
import 'package:kmart/common_widgets/common_text_widget.dart';
import 'package:kmart/controllers/forget_password.dart';
import 'package:kmart/controllers/signin_controller.dart';
import '../../common_widgets/custom_button.dart';
import '../../common_widgets/custom_textfield.dart';
import '../../const/consts.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final signinController = Get.put(SigninController());
  final _userEmailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ForgetPasswordController forgetPasswordController =
        Get.put(ForgetPasswordController());

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
                    nameTitle: "Forgate password",
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold),
                const SizedBox(
                  height: 10,
                ),
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
                      const SizedBox(
                        height: 20,
                      ),
                      CustomButton(
                        btnColor: redColor,
                        color: whiteColor,
                        title: "Forget",
                        onTap: () async {
                          String email = _userEmailController.text.trim();
                          if (email.isEmpty) {
                            Get.snackbar("Error", "Please Enter all details");
                          } else {
                            String email = _userEmailController.text.trim();

                            forgetPasswordController.forgetPassword(email);
                          }
                        },
                      ),
                      const SizedBox(
                        height: 5,
                      ),
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
