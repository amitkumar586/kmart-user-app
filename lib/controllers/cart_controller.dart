import 'package:get/get.dart';

class CartController extends GetxController {
  var totalP = 0.obs;

  calculate(data) {
    for (var i = 0; i < data.length; i++) {
      totalP = totalP + int.parse(data[i]['tPrice'].toString());
    }
  }
}
