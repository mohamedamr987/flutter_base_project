import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppColors {
  // static const Color primary = Color(0xFFFF725E);
  static const Color primary =
      appFlavor == "eljomla" ? Color(0xFF12B76A) : Color(0xFF47B9ED);
  static const Color secondary = Color(0xFFF4823B);
  static const Color third = Color(0xFF587BBA);
  static const Color fourth = Color(0xFFBAD2F3);

  static const Color textSecondary = Color(0xFF777777);

  static const Color black = Colors.black;
  static const Color white = Color(0xffFFFFFF);

  static const Color lightGray = Color(0xFFCCCCCC);
  static const Color gray = Color(0xFF868686);
  static const Color textFieldColor = Color(0xFFF5F6FA);
  // static const Color darkGray = Color(0xFF484848);
  static const Color darkGray = Color(0xFF262626);

  static const Color green = Color(0xFF48FF8A);
  static const Color greenSacro = Color(0xFF31A411);

  static const Color red = Color(0xffFF3333);
  static const Color yellow = Color(0xffF6C545);
  static const Color background = Colors.white;
}

extension AppColorsTheme on Color {
  Color get theme {
    return this;
  }
}
