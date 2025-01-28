import 'package:flutter/material.dart';

class AppWidgets {

  AppWidgets._();

  static customText({
    required String text,
    required Color color,
    required double fontSize,
    FontWeight? fontWeight,
    double? height,
    int? maxLines,
    TextOverflow? textOverflow,
  }){
    return Text(
      text,
      maxLines: maxLines,
      overflow: textOverflow,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        height: height,
      ),
    );
  }

  static customCard({
    required Color color,
    required Widget child,
}){
    return Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 43),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        //color: Colors.red.withOpacity(0.25),
        color: color,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: color,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: child,
          ),
        ),
      ),
    );
}


}