import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:fre_a_tec/provider/auth_provider.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _mailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final _titleTextStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 30,
  );

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (_, authProvider, __) {
      return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Text("Fre-A-Tec", style: _titleTextStyle)
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: TextFormField(
                controller: _mailController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: TextFormField(
                controller: _passwordController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: TextButton(
                child: Text("Login"),
                onPressed: () async {
                  if (_mailController.text.isNotEmpty &&
                      _passwordController.text.isNotEmpty) {
                    Provider.of<AuthProvider>(context, listen: false)
                        .signInWithMail(
                      _mailController.text,
                      _passwordController.text,
                    );
                  }
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}
