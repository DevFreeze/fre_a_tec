import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fre_a_tec/provider/category_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddDailyTask extends StatefulWidget {
  @override
  _AddDailyTaskState createState() => _AddDailyTaskState();
}

class _AddDailyTaskState extends State<AddDailyTask> {
  PickedFile _image;
  final picker = ImagePicker();
  final _titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tagesaufgabe hinzufügen"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _titleController,
                    decoration: InputDecoration(hintText: "Aufgabentitel"),
                  ),
                ),
                _image == null
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 100.0,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                          ),
                          child: Center(
                            child: Text('Kein Bild ausgewählt.'),
                          ),
                        ),
                      )
                    : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.file(File(_image.path)),
                    ),
                TextButton(
                  child:
                      Text("${_image != null ? "Neues " : ""}Bild hochladen"),
                  onPressed: () {
                    getImage();
                  },
                ),
                if (_image != null)
                  TextButton(
                    child: Text("Bild löschen"),
                    onPressed: () {
                      setState(() {
                        _image = null;
                      });
                    },
                  )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 50.0,
              child: TextButton(
                child: Text("Weiter"),
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Colors.blue,
                ),
                onPressed: () {
                  if(_titleController.text.isNotEmpty && _image != null) {
                    Provider.of<CategoryProvider>(context, listen: false).addDailyTask(_titleController.text, _image);
                    Navigator.of(context).pop();
                  } else {
                    if(_titleController.text.isEmpty) {
                      _showMyDialog("Aufgabentitel vergessen");
                    } else {
                      _showMyDialog("Bild vergessen");
                    }
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = pickedFile;
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> _showMyDialog(String text) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Aufgabe hochladen'),
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
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
