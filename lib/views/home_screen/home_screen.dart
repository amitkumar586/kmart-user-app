import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:kmart/views/category/flash_sale.dart';
import '../../common_widgets/home_buttons.dart';
import '../../const/consts.dart';
import '../../const/list.dart';
import '../../services/fcm.dart';
import '../../services/notification_service.dart';
import '../all products/all_products.dart';
import '../banners/custom_banners.dart';
import 'components/feature_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  NotoficationService notoficationService = NotoficationService();

  @override
  void initState() {
    notoficationService.requestNotificationPermission();
    notoficationService.getDeviceToken();
    notoficationService.firebaseInit(context);
    notoficationService.setupIntractMessage(context);
    FcmServie.firebaseInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: lightGrey,
      padding: const EdgeInsets.all(12),
      child: Scaffold(
        body: Column(
          children: [
            Container(
              alignment: Alignment.center,
              height: 60,
              color: lightGrey,
              child: TextFormField(
                decoration: InputDecoration(
                    border: InputBorder.none,
                    filled: true,
                    fillColor: whiteColor,
                    hintText: "Search anything",
                    hintStyle: TextStyle(color: textfieldGrey),
                    suffixIcon: const Icon(Icons.search)),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    /////////

                    const BannerWigit(),

                    const SizedBox(
                      height: 10,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                        2,
                        (index) => HomeButton(
                            height: MediaQuery.of(context).size.height * 0.12,
                            width: MediaQuery.of(context).size.width / 3,
                            icnData: index == 0 ? icTodaysDeal : icFlashDeal,
                            title: index == 0 ? "To Day Deal" : "Flash Sale",
                            onpress: () {
                              print(index);
                              if (index == 1) {
                                Get.to(const FlashSale());
                              }
                            }),
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    //swiper brands
                    CarouselSlider(
                      items: secondsliderlist.map((i) {
                        return Builder(
                          builder: (context) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    image: AssetImage(i), fit: BoxFit.fill),
                              ),
                            );
                          },
                        );
                      }).toList(),
                      options: CarouselOptions(
                        aspectRatio: 16 / 9,
                        height: 150,
                        autoPlay: true,
                        enlargeCenterPage: true,
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                        3,
                        (index) => HomeButton(
                            height: MediaQuery.of(context).size.height * 0.1,
                            width: MediaQuery.of(context).size.width / 4,
                            icnData: index == 0
                                ? icTopCategories
                                : index == 1
                                    ? icBrands
                                    : icTopSeller,
                            title: index == 0
                                ? "Top Categories"
                                : index == 1
                                    ? "Brands"
                                    : "Top Sellers",
                            onpress: () {}),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // Featured Categories
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Text Feature",
                        style: TextStyle(
                            fontFamily: bold,
                            color: darkFontGrey,
                            fontSize: 20),
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          3,
                          (index) => Column(
                            children: [
                              FeaturedButtons(
                                icons: faeturedlist1Images[index],
                                title: faeturedlist1Title[index],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              FeaturedButtons(
                                icons: faeturedlist2Images[index],
                                title: faeturedlist2Title[index],
                              ),
                            ],
                          ),
                        ).toList(),
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    Container(
                      padding: const EdgeInsets.all(5),
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: redColor,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Featured Products",
                            style: TextStyle(
                                color: whiteColor,
                                fontFamily: bold,
                                fontSize: 18),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: List.generate(
                                6,
                                (index) => Container(
                                  padding: const EdgeInsets.all(6),
                                  margin: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: whiteColor,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        imgP1,
                                        width: 145,
                                        fit: BoxFit.cover,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Laptop 4GB/64GB",
                                        style: TextStyle(
                                          fontFamily: semibold,
                                          color: darkFontGrey,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "\$600",
                                        style: TextStyle(
                                            fontFamily: bold,
                                            color: redColor,
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          //////////////////////

                          ////////////////
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    //swiper brands
                    CarouselSlider(
                      items: secondsliderlist.map((i) {
                        return Builder(
                          builder: (context) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      image: AssetImage(i), fit: BoxFit.fill)),
                            );
                          },
                        );
                      }).toList(),
                      options: CarouselOptions(
                        aspectRatio: 16 / 9,
                        height: 150,
                        autoPlay: true,
                        enlargeCenterPage: true,
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    //All Products Secton
                    // GridView.builder(
                    //     physics:  NeverScrollableScrollPhysics(),
                    //     shrinkWrap: true,
                    //     itemCount: 6,
                    //     gridDelegate:
                    //          SliverGridDelegateWithFixedCrossAxisCount(
                    //             mainAxisSpacing: 8,
                    //             crossAxisCount: 2,
                    //             crossAxisSpacing: 8,
                    //             mainAxisExtent: 300),
                    //     itemBuilder: (context, index) {
                    //       return
                    //        Container(
                    //         padding:  EdgeInsets.symmetric(
                    //             vertical: 10, horizontal: 5),
                    //         decoration: BoxDecoration(
                    //             color: whiteColor,
                    //             borderRadius: BorderRadius.circular(10)),
                    //         child: Column(
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           children: [
                    //             Image.asset(
                    //               imgP5,
                    //               width: 200,
                    //               height: 200,
                    //               fit: BoxFit.cover,
                    //             ),
                    //              Spacer(),
                    //              Text(
                    //               "Laptop 4GB/64GB",
                    //               style: TextStyle(
                    //                 fontFamily: semibold,
                    //                 color: darkFontGrey,
                    //               ),
                    //             ),
                    //              SizedBox(
                    //               height: 10,
                    //             ),
                    //              Text(
                    //               "\$600",
                    //               style: TextStyle(
                    //                   fontFamily: bold,
                    //                   color: redColor,
                    //                   fontSize: 16),
                    //             ),
                    //           ],
                    //         ),
                    //       );
                    //     })
                    const AllProducts()
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
