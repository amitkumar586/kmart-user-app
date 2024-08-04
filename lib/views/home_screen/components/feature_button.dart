import '../../../const/consts.dart';

class FeaturedButtons extends StatelessWidget {
  final String? title;
  final String? icons;

  const FeaturedButtons({super.key, this.title, this.icons});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 4))
          ]),
      child: Row(
        children: [
          Image.asset(
            icons!,
            width: 50,
            fit: BoxFit.fill,
          ),
          const SizedBox(
            width: 2,
          ),
          Text(
            title!,
            style: TextStyle(
              fontFamily: semibold,
              color: darkFontGrey,
            ),
          )
        ],
      ),
    );
  }
}
