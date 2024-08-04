import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

import '../const/consts.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final Color color;
  final Color btnColor;
  final Callback? onTap;
  const CustomButton({
    super.key,
    required this.title,
    required this.color,
    required this.btnColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.6,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              backgroundColor: btnColor,
              padding: const EdgeInsets.all(12.0)),
          onPressed: onTap,
          child: Text(
            title,
            style: TextStyle(color: color),
          )),
    );
  }
}
