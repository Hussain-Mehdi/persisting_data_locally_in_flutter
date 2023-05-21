import 'package:flutter/material.dart';
import 'package:persisting_data_locally_in_flutter/data/share_prefs.dart';
import 'package:persisting_data_locally_in_flutter/model/password.dart';
import 'package:persisting_data_locally_in_flutter/screens/password_detail.dart';
import '../data/share_prefs.dart';

import '../data/sembast_db.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({super.key});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  late SembastDb db;

  int settingColor = 0xff1976d2;
  double fontSize = 16;
  SPSetting setting = SPSetting();

  @override
  void initState() {
    db = SembastDb();
    setting.init().then((value) {
      setState(() {
        settingColor = setting.getColor();
        fontSize = setting.getFontSize();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
          future: getPassword(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            List<Password> password = snapshot.data ?? [];
            return ListView.builder(
                itemCount: password == null ? 0 : password.length,
                itemBuilder: (_, index) {
                  return Dismissible(
                      key: Key(password[index].id.toString()),
                      child: ListTile(
                          title: Text(password[index].name),
                          trailing: const Icon(Icons.edit),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) =>
                                  PasswordDetailDialog(password[index], false),
                            );
                          }));
                });
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return PasswordDetailDialog(Password('', ''), true);
            },
          );
        },
        backgroundColor: Color(settingColor),
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<List<Password>> getPassword() async {
    List<Password> passwords = await db.getPassowrds();
    return passwords;
  }
}
