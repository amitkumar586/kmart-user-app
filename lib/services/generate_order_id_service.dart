import 'dart:math';

String generateOrderId() {
  DateTime now = DateTime.now();

  int randomIdNumber = Random().nextInt(99999);

  String id = '${(now.microsecondsSinceEpoch)}_$randomIdNumber';
  return id;
}
