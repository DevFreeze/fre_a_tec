import 'package:flutter/material.dart';
import 'package:fre_a_tec/provider/user_provider.dart';
import 'package:fre_a_tec/utils/enums/auth_status.dart';

import 'package:provider/provider.dart';

import 'package:fre_a_tec/provider/auth_provider.dart';

class SetPassword extends StatefulWidget {
  @override
  _SetPasswordState createState() => _SetPasswordState();
}

class _SetPasswordState extends State<SetPassword> {
  final _newPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: _newPasswordController,
          ),
          TextButton(
            child: Text("Weiter"),
            onPressed: () async {
              if (_newPasswordController.text.isNotEmpty) {
                String result =
                    await Provider.of<AuthProvider>(context, listen: false)
                        .updatePassword(_newPasswordController.text);
                switch (result) {
                  case 'weak-password':
                    {
                      _showMyDialog(
                          "Das Passwort ist nicht stark genug", false);
                      break;
                    }
                  case 'requires-recent-login':
                    {
                      _showMyDialog(
                          "Der letzet Login ist zu lange her, du musst dich nochmal anmelden.",
                          true);
                      break;
                    }
                }
              }
            },
          ),
        ],
      ),
    );
  }

  Future<void> _showMyDialog(String text, bool hasToLoginAgain) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Neues Password'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(text),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Ok'),
              onPressed: () {
                if (hasToLoginAgain) {
                  Provider.of<AuthProvider>(context, listen: false).signOut();
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
