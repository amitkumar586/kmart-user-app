import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  RxString profileImgPath = ''.obs;

  Future changeImage() async {
    final ImagePicker imgPicker = ImagePicker();

    final image = await imgPicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      profileImgPath.value = image.path.toString();
    }
  }
}
