import 'package:flutter/material.dart';
import 'package:persisting_data_locally_in_flutter/data/sembast_db.dart';
import 'package:persisting_data_locally_in_flutter/model/password.dart';

import 'passwords.dart';

class PasswordDetailDialog extends StatefulWidget {
  final Password password;
  final bool isNew;

  const PasswordDetailDialog(this.password, this.isNew);

  @override
  State<PasswordDetailDialog> createState() => _PasswordDetailDialogState();
}

class _PasswordDetailDialogState extends State<PasswordDetailDialog> {
  final TextEditingController txtName = TextEditingController();
  final TextEditingController txtPassword = TextEditingController();
  bool hidePassowrd = true;

  @override
  Widget build(BuildContext context) {
    String title = (widget.isNew) ? 'Insert new Password' : 'Edit Password';
    return AlertDialog(
      title: Text(title),
      content: Column(
        children: [
          TextField(
            controller: txtName,
            decoration: InputDecoration(
              hintText: 'Description',
            ),
          ),
          TextField(
            controller: txtPassword,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      hidePassowrd = !hidePassowrd;
                    });
                  },
                  icon: hidePassowrd
                      ? const Icon(Icons.visibility)
                      : const Icon(Icons.visibility_off)),
              hintText: 'Password',
            ),
            obscureText: hidePassowrd,
          )
        ],
      ),
      actions: [
        TextButton(
            onPressed: () {
              widget.password.name = txtName.text;
              widget.password.password = txtPassword.text;
              SembastDb db = SembastDb();
              (widget.isNew)
                  ? db.addPassword(widget.password)
                  : db.updatePassword(widget.password);
              print(
                  "Password added successfully======================================$txtPassword.text");
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PasswordScreen(),
                  ));
            },
            child: const Text("Save")),
        TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close")),
      ],
    );
  }
}
