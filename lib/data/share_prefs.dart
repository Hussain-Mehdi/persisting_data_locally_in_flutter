import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class SPSetting {
  final String fontSizeKey = 'font_size';
  final String colorKey = 'color';
  final String themeOn = "theme_on";
  static late SharedPreferences _sp;
  static SPSetting? _instance;

  SPSetting._internal();

  factory SPSetting() {
    _instance ??= SPSetting._internal();

    return _instance as SPSetting;
  }

  Future init() async {
    _sp = await SharedPreferences.getInstance();
  }

  Future setColor(int color) async {
    return _sp.setInt(colorKey, color);
  }

  int getColor() {
    int? color = _sp.getInt(colorKey);
    color ??= 0xff1976d2;
    return color;
  }

  Future setFontSize(double fontSize) async {
    return _sp.setDouble(fontSizeKey, fontSize);
  }

  double getFontSize() {
    double? fontSize = _sp.getDouble(fontSizeKey);

    fontSize ??= 14;
    return fontSize;
  }

  Future setTheme(bool theme) async {
    return _sp.setBool(themeOn, theme);
  }

  bool getTheme() {
    bool? themePref = _sp.getBool(themeOn);
    themePref ??= false;
    return themePref;
  }
}
