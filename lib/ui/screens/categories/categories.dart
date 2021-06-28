import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import 'package:fre_a_tec/provider/category_provider.dart';
import 'package:fre_a_tec/ui/widgets/common/common_list_tile.dart';

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kategorien"),
      ),
      body: Consumer<CategoryProvider>(builder: (_, categoryProvider, __) {
        return StreamBuilder<QuerySnapshot>(
            stream: categoryProvider.categoryStream(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) => CommonListTile(
                    title: snapshot.data.docs[index]['title'],
                    onClick: () {
                      Navigator.of(context)
                          .pushNamed("/${snapshot.data.docs[index]['path']}");
                    },
                  ),
                );
              }
              return Container();
            });
      }),
    );
  }
}
