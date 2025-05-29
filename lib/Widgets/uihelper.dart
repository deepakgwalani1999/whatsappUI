import 'package:flutter/material.dart';

class UiHelper {
  static customButton({
    required VoidCallback callback,
    required String buttonName,
  }) {
    return SizedBox(
      height: 45,
      width: 390,
      child: ElevatedButton(
        onPressed: () {
          callback();
        },
        style:ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(150))          )
        ),
        child: Text(
          buttonName,
          style: TextStyle(fontSize: 14, color: Colors.white),
        ),
      ),
    );
  }

  static customText({
    required String text,
    required double textHeight,
    Color? color,
    FontWeight? fontWeight,
    
  }) {
    return Text(
      text,
      style: TextStyle(
        fontSize: textHeight,
        color: color ?? Color(0xff5e5e5e),
        fontWeight: fontWeight,
        fontFamily: "Roboto",
       
      ),
    );
  }
}
