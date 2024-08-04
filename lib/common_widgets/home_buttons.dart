import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import '../const/consts.dart';

class HomeButton extends StatelessWidget {
  final double height;
  final double width;
  final String icnData;
  final String title;
  final Callback onpress;

  const HomeButton({
    super.key,
    required this.height,
    required this.width,
    required this.icnData,
    required this.title,
    required this.onpress,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onpress,
      child: Container(
        height: height,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 4))
        ], borderRadius: BorderRadius.circular(10), color: whiteColor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              icnData,
              width: width,
              height: 26,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              title,
            )
          ],
        ),
      ),
    );
  }
}
