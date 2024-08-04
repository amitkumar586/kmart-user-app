import '../const/consts.dart';

appLogoWidget() {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      color: Colors.white,
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Image.asset(
        icAppLogo,
        height: 55,
        width: 50,
      ),
    ),
  );
}
