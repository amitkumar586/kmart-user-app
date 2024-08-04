import '../const/consts.dart';

Text commonTextMethod({nameTitle, fontSize, fontWeight, color}) {
  return Text(
    nameTitle,
    style: TextStyle(color: color, fontWeight: fontWeight, fontSize: fontSize),
  );
}
