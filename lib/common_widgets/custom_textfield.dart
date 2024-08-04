import '../const/consts.dart';

class CustomTextField extends StatelessWidget {
  final String title;
  final String hintText;
  final TextEditingController controller;
  final bool? isObscureText;
  final String? isObscureCharacter;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;

  const CustomTextField({
    super.key,
    required this.title,
    required this.hintText,
    required this.controller,
    this.isObscureText = false,
    this.isObscureCharacter = '*',
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        TextFormField(
          controller: controller,
          obscureText: isObscureText!,
          obscuringCharacter: isObscureCharacter!,
          // enabled: false,
          keyboardType: keyboardType,
          decoration: InputDecoration(
              isDense: true,
              filled: true,
              fillColor: lightGrey,
              border: InputBorder.none,
              prefixIcon: prefixIcon,
              hintStyle: TextStyle(fontFamily: semibold, color: textfieldGrey),
              hintText: hintText,
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: redColor, width: 2)),
              suffixIcon: suffixIcon),
        ),
      ],
    );
  }
}
