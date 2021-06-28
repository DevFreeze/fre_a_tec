import 'package:firebase_messaging/firebase_messaging.dart';


class MessagingService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  String deviceToken;

  Future<String> initialise() async {
    _firebaseMessaging.requestPermission();
    _firebaseMessaging.getToken().then((token) {
      print("TOKEN INIT: " + token);
      deviceToken = token;
    }).catchError((error) {
      print("Error" + error.toString());
      return "Error";
    });
    return null;
  }

}
