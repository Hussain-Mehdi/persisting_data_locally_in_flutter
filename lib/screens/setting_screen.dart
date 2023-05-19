import "package:flutter/material.dart";
import '../model/font_size.dart';
import '../data/share_prefs.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  int settingColor = 0xff1976d2;

  double singleFontSize = 16;
  List<int> colors = [
    0xff455a64,
    0xffffc107,
    0xff673ab7,
    0xfff57c00,
    0xff795548
  ];

  List<FontSize> fontSizes = [
    FontSize('small', 12),
    FontSize("Medium", 16),
    FontSize("Large", 20),
    FontSize("Extra Large", 24),
  ];

  SPSetting setting = SPSetting();
  bool buttonOn = false;

  @override
  void initState() {
    setting.init().then((value) {
      setState(() {
        settingColor = setting.getColor();

        singleFontSize = setting.getFontSize();

        buttonOn = setting.getTheme();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          brightness: buttonOn == true ? Brightness.dark : Brightness.light),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Setting"),
          backgroundColor: Color(settingColor),
          actions: [
            Switch(
              value: buttonOn,
              activeColor: Color(settingColor),
              onChanged: changeTheme,
            ),
          ],
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Dark",
                style: TextStyle(fontSize: 20, color: Color(settingColor)),
              ),
              Text(
                "Chose the App font size",
                style: TextStyle(
                    fontSize: singleFontSize, color: Color(settingColor)),
              ),
              DropdownButton(
                items: getDropdownMenuItem(),
                // fontSizes.map((e) {
                //   return DropdownMenuItem(
                //     value: e.size.toString(),
                //     child: Text(e.name),
                //   );
                // }).toList(),
                onChanged: changeSize,
              ),
              const Text("App Main Color"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () => setColor(colors[0]),
                    child: ColorSquare(colors[0]),
                  ),
                  GestureDetector(
                    onTap: () => setColor(colors[1]),
                    child: ColorSquare(colors[1]),
                  ),
                  GestureDetector(
                    onTap: () => setColor(colors[2]),
                    child: ColorSquare(colors[2]),
                  ),
                  GestureDetector(
                    onTap: () => setColor(colors[3]),
                    child: ColorSquare(colors[3]),
                  ),
                  GestureDetector(
                    onTap: () => setColor(colors[4]),
                    child: ColorSquare(colors[4]),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void setColor(int colorCode) {
    setState(() {
      settingColor = colorCode;
      setting.setColor(settingColor);
    });
  }

  List<DropdownMenuItem<String>> getDropdownMenuItem() {
    List<DropdownMenuItem<String>> items = [];
    for (FontSize fontSize in fontSizes) {
      items.add(DropdownMenuItem(
        value: fontSize.size.toString(),
        child: Text(fontSize.name),
      ));
    }

    return items;
  }

  changeSize(String? newSize) {
    setting.setFontSize(double.parse(newSize ?? '14'));
    setState(() {
      singleFontSize = double.parse(newSize ?? '14');
    });
  }

  changeTheme(bool value) {
    setting.setTheme(value);
    setState(() {
      buttonOn = value;
    });
  }
}

class ColorSquare extends StatelessWidget {
  const ColorSquare(this.colorCode);
  final int colorCode;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: 72,
        width: 72,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Color(colorCode)),
      ),
    );
  }
}
