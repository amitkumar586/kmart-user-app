import 'package:get/get.dart';

import '../../../const/consts.dart';

class ProfileCommonButton extends StatelessWidget {
  final String? title;
  final String? subtitle;
  const ProfileCommonButton({
    super.key,
    this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      height: Get.height / 15,
      width: Get.width / 3.8,
      decoration: BoxDecoration(
          color: whiteColor, borderRadius: BorderRadius.circular(6)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title!,
            style:
                TextStyle(color: darkFontGrey, fontFamily: bold, fontSize: 14),
          ),
          Text(
            subtitle!,
            style: TextStyle(color: fontGrey, fontSize: 10),
          ),
        ],
      ),
    );
  }
}
