import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import '../../const/consts.dart';
import '../../controllers/banners_controller.dart';

class BannerWigit extends StatelessWidget {
  const BannerWigit({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final BannerController bannerController = Get.put(BannerController());

    return Obx(
      () => CarouselSlider(
        items: bannerController.bannersList
            .map(
              (imageUrl) => ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  width: Get.width,
                ),
              ),
            )
            .toList(),
        options: CarouselOptions(
            scrollDirection: Axis.horizontal,
            aspectRatio: 2.5,
            height: Get.height * 0.21,
            autoPlay: true,
            viewportFraction: 0.99,
            enlargeCenterPage: true,
            animateToClosest: true),
      ),
    );
  }
}
