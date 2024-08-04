import 'package:get/get.dart';
import 'package:kmart/controllers/home_screen_controller.dart';
import 'package:kmart/views/cart/cart_screen.dart';
import 'package:kmart/views/category/category_screen.dart';
import 'package:kmart/views/home_screen/home_screen.dart';
import '../../common_widgets/exit_dialog.dart';
import '../../const/consts.dart';
import '../profile_Screen/profile_screen.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeScreenController());

    var navbarItems = [
      BottomNavigationBarItem(
          icon: Image.asset(icHome, width: 26), label: home),
      BottomNavigationBarItem(
          icon: Image.asset(icCategories, width: 26), label: categories),
      BottomNavigationBarItem(
          icon: Image.asset(icCart, width: 26), label: cart),
      BottomNavigationBarItem(
          icon: Image.asset(icProfile, width: 26), label: account)
    ];

    var navBody = [
      const HomeScreen(),
      const CategoryScreen(),
      const CartScreen(),
      ProfileScreen()
    ];

    return WillPopScope(
      onWillPop: () async {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => exitDialog(context));

        return false;
      },
      child: Scaffold(
        body: Column(
          children: [
            Obx(() => Expanded(
                child: navBody.elementAt(controller.currentNavIndx.value))),
          ],
        ),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            backgroundColor: whiteColor,
            selectedItemColor: redColor,
            selectedLabelStyle: const TextStyle(fontFamily: semibold),
            type: BottomNavigationBarType.shifting,
            items: navbarItems,
            currentIndex: controller.currentNavIndx.value,
            onTap: (value) {
              controller.currentNavIndx.value = value;
            },
          ),
        ),
      ),
    );
  }
}
