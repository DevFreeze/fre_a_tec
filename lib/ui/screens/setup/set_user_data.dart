import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:fre_a_tec/provider/user_provider.dart';

class SetUserData extends StatelessWidget {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text("Gib bitte Deine Namen ein."),
          ),
          TextFormField(
            controller: _firstNameController,
            decoration: InputDecoration(
              hintText: "Vorname"
            ),
          ),
          TextFormField(
            controller: _lastNameController,
            decoration: InputDecoration(
                hintText: "Nachname"
            ),
          ),
          TextButton(
            child: Text("Weiter"),
            onPressed: () async {
              if (_firstNameController.text.isNotEmpty &&
                  _lastNameController.text.isNotEmpty) {
                Provider.of<UserProvider>(context, listen: false).writeUserInDB(
                    _firstNameController.text, _lastNameController.text);
              }
            },
          ),
        ],
      ),
    );
  }
}
