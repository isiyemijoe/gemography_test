import 'package:get/get.dart';
import 'package:flutter/material.dart';

class UIhelper {
  static void error(String message, {String title = "Error"}) {
    Get.snackbar(title, message,
        titleText: Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        snackStyle: SnackStyle.FLOATING,
        shouldIconPulse: true,
        icon: Icon(
          Icons.error,
          color: Colors.white,
          size: 24,
        ));
  }

  static Widget textField(
      BuildContext context, TextEditingController controller,
      {FocusNode focusNode,
      onChanged,
      Widget prefix,
      String errorText = "",
      bool hideText = false,
      String hint = "",
      Widget suffix}) {
    return Column(
      children: [
        Container(
          height: 50,
          color: Color(0xffF3F4F6),
          child: Row(
            children: [
              if (prefix != null)
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: prefix,
                ),
              Flexible(
                child: TextField(
                  controller: controller,
                  style: Theme.of(context).textTheme.bodyText1,
                  obscureText: hideText,
                  onChanged: onChanged,
                  decoration: InputDecoration(
                    hintText: hint,
                  ),
                ),
              ),
              if (suffix != null)
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: suffix,
                ),
            ],
          ),
        ),
        if (errorText.isNotEmpty)
          Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  errorText,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      .copyWith(color: Colors.red, fontSize: 12),
                ),
              ))
      ],
    );
  }
}
