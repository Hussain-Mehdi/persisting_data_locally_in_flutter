import 'package:flutter/material.dart';
import 'package:persisting_data_locally_in_flutter/data/share_prefs.dart';
import 'package:persisting_data_locally_in_flutter/screens/passwords.dart';

import 'setting_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int settingColor = 0xff1976d2;
  double fontSize = 16;
  SPSetting setting = SPSetting();

  @override
  void initState() {
    getSetting();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getSetting(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Color(settingColor),
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const DrawerHeader(child: Text("GlobeApp Menu")),
                ListTile(
                  title: Text(
                    "Settings",
                    style: TextStyle(fontSize: fontSize),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SettingScreen(),
                        ));
                  },
                ),
                ListTile(
                  title: Text(
                    "Password",
                    style: TextStyle(fontSize: fontSize),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PasswordScreen(),
                        ));
                  },
                ),
              ],
            ),
          ),
          body: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('./images/homescreen.jpg'),
                    fit: BoxFit.cover)),
          ),
        );
      },
    );
  }

  Future getSetting() async {
    setting = SPSetting();
    setting.init().then((value) {
      setState(() {
        settingColor = setting.getColor();
        fontSize = setting.getFontSize();
      });
    });
  }
}
