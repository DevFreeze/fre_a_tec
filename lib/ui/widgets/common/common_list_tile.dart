import 'package:flutter/material.dart';

class CommonListTile extends StatelessWidget {

  final String title;
  final Function onClick;

  const CommonListTile({Key key, this.title, this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(title),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: onClick,
      ),
    );
  }

}