import 'dart:io';

import 'package:get/get.dart';
import 'package:kmart/common_widgets/bg_widget.dart';

import 'package:kmart/controllers/profile_controller.dart';
import '../../common_widgets/custom_textfield.dart';
import '../../const/consts.dart';

class EditProfieleScreen extends StatefulWidget {
  const EditProfieleScreen({super.key});

  @override
  State<EditProfieleScreen> createState() => _EditProfieleScreenState();
}

class _EditProfieleScreenState extends State<EditProfieleScreen> {
  TextEditingController demo = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var myImgController = Get.find<ProfileController>();

    return bgWidget(
        child: Scaffold(
      appBar: AppBar(),
      body: Container(
        decoration: BoxDecoration(
            color: whiteColor, borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
        margin: const EdgeInsets.symmetric(horizontal: 12),
        child: Obx(
          () => Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              myImgController.profileImgPath.isEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset(
                        imgProfile2,
                        height: 60,
                        width: 60,
                        fit: BoxFit.cover,
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.file(
                        File(
                          myImgController.profileImgPath.toString(),
                        ),
                        fit: BoxFit.cover,
                        width: 60,
                        height: 60,
                      )),

              const SizedBox(
                height: 10,
              ),

              InkWell(
                onTap: () {
                  myImgController.changeImage();
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(4),
                  height: Get.height / 20,
                  width: Get.width / 5,
                  decoration: BoxDecoration(
                      color: redColor, borderRadius: BorderRadius.circular(6)),
                  child: Text(
                    "Change",
                    style: TextStyle(color: whiteColor),
                  ),
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              CustomTextField(
                  title: 'Name', hintText: 'Enter Name', controller: demo),

              const SizedBox(
                height: 20,
              ),

              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(4),
                height: Get.height / 20,
                width: Get.width,
                decoration: BoxDecoration(
                    color: redColor, borderRadius: BorderRadius.circular(6)),
                child: Text(
                  "Change",
                  style: TextStyle(color: whiteColor, fontFamily: semibold),
                ),
              ),

              //////
            ],
          ),
        ),
      ),
    ));
  }
}
