import 'dart:math';

import 'package:flutter/material.dart';

class AppColor {
  static Color randomColor() {
    var red = Random.secure().nextInt(255);
    var greed = Random.secure().nextInt(255);
    var blue = Random.secure().nextInt(255);
    return Color.fromARGB(255, red, greed, blue);
  }

  ///主色调
  static var rcMainColor = Color(0xff864AFF);

  ///通用色
  static var rcNormalColor = Color(0xff999999);
}
