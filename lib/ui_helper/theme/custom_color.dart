import 'package:flutter/material.dart';
import 'package:shovving_pre/ui_helper/common_ui_helper.dart';

class CColor {
  ///임시 색상
  static Color dark = const Color(0xff2d2a26);
  static Color lightDark = const Color(0xff2d2a26).withOpacity(0.7);
  static Color lightGray = const Color(0xfff5f5f5);
  static Color darkGray = const Color(0xfff4f4f4);
  static Color primary = const Color(0xff00ff80);
  static Color gray = const Color(0xffD6D1CA);

  static Color deepBlueBlack = const Color(0xff292d32);
  static Color blueGreen = const Color(0xff80ccb8);
  static Color subLightGray = const Color(0xffd5dbdf);

  static Color pink = const Color(0xffFF82A0);
  static Color redCaution = const Color(0xffFF003D);

  static Color logoPink = const Color(0xffF763BC);


  ///main Color
  static Color mainPurple = const Color(0xffC1A7FB);

  static Color mainYellow = const Color(0xffFDDE6A);

  static Color mainGreen = const Color(0xff58BD71);

  static Color brightGray = const Color(0xffF7F6F9);

  static Color lavender = const Color(0xffC1A7FB);

  static Color lemon = const Color(0xffFDDE6A);

  static Color grassGreen = const Color(0xff71C587);



}

Color itemColor(int colorIndex, int index){
  return  GColor.fColorList[(colorIndex+index~/5)%(GColor.fColorList.length-1)][index%5];
}