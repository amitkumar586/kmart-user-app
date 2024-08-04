import 'package:flutter/services.dart';

import '../const/consts.dart';

Widget exitDialog(context) {
  return Dialog(
    child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        decoration: BoxDecoration(
            color: lightGrey, borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Confirm",
              style: TextStyle(
                  fontFamily: bold, fontSize: 18, color: darkFontGrey),
            ),
            const Divider(),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Are you sure you want to exit?",
              style: TextStyle(
                  fontFamily: bold, fontSize: 16, color: darkFontGrey),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    SystemNavigator.pop();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 30,
                    width: 60,
                    decoration: BoxDecoration(
                        color: redColor,
                        borderRadius: BorderRadius.circular(6)),
                    child: Text(
                      "Yes",
                      style: TextStyle(
                          fontFamily: bold, fontSize: 16, color: whiteColor),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 30,
                    width: 60,
                    decoration: BoxDecoration(
                        color: redColor,
                        borderRadius: BorderRadius.circular(6)),
                    child: Text(
                      "No",
                      style: TextStyle(
                          fontFamily: bold, fontSize: 16, color: whiteColor),
                    ),
                  ),
                ),
              ],
            ),
          ],
        )),
  );
}
