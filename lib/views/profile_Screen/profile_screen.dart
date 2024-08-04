import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kmart/common_widgets/bg_widget.dart';
import 'package:kmart/views/auth/login_screen.dart';
import 'package:kmart/views/profile_Screen/edit_profile_screen.dart';
import '../../const/consts.dart';
import '../../const/list.dart';
import 'componenets/profile_common_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ProfileController profileController = Get.put(ProfileController());

    return bgWidget(
        child: Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          /////////////////
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () {
                  Get.to(() => const EditProfieleScreen());
                },
                child: Icon(
                  Icons.edit,
                  color: whiteColor,
                ),
              ),
            ),
          ),

          ///
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset(
                    imgProfile2,
                    height: 62,
                    width: 62,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Amit Kumar Gangwar",
                        style: TextStyle(
                            color: whiteColor, fontFamily: bold, fontSize: 10),
                      ),
                      Text(
                        "amitkumargangwar189@gmail.com",
                        style: TextStyle(color: whiteColor, fontSize: 10),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    GoogleSignIn googleSignIn = GoogleSignIn();

                    googleSignIn.signOut();

                    Get.offAll(() => const LoginScreen());
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 20,
                    width: 50,
                    decoration: BoxDecoration(
                        border: Border.all(color: whiteColor),
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(
                      "Logout",
                      style: TextStyle(color: whiteColor, fontSize: 8),
                    ),
                  ),
                )
              ],
            ),
          ),
          //////

          const SizedBox(
            height: 20,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ProfileCommonButton(title: "00", subtitle: "AmitShop"),
              ProfileCommonButton(title: "00", subtitle: "AmitShop"),
              ProfileCommonButton(title: "00", subtitle: "AmitShop"),
            ],
          ),

          const SizedBox(
            height: 15,
          ),

          Container(
            color: redColor,
            child: Container(
              margin: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: whiteColor, borderRadius: BorderRadius.circular(5)),
              child: ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (context, index) {
                  return Divider(
                    color: lightGrey,
                  );
                },
                itemCount: profilebtnList.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: Image.asset(
                      profileItemList[index],
                      width: 22,
                    ),
                    title: Text(
                      profilebtnList[index],
                      style: TextStyle(fontFamily: bold, color: darkFontGrey),
                    ),
                  );
                },
              ),
            ),
          )

          ///
        ],
      )),
    ));
  }
}
