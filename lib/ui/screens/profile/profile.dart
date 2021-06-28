import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:fre_a_tec/provider/auth_provider.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profil"),
      ),
      body: ListView(
        children: [
          TextButton(
            child: Text("Logout"),
            onPressed: () {
              Provider.of<AuthProvider>(context, listen: false).signOut();
            },
          ),
        ],
      ),
    );
  }
}
