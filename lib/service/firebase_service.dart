import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';


class FirebaseMessage{
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  Future<void> initMessaging() async{
    _firebaseMessaging.configure(
      onMessage: save,
//          (Map<String, dynamic> message) async {
//        print("onMessage: $message");
//      },
      onBackgroundMessage: save,
//      onBackgroundMessage: myBackgroundMessageHandler,
      onLaunch: save,
//          (Map<String, dynamic> message) async {
//        print("onLaunch: $message");
//      },
      onResume: save,
//          (Map<String, dynamic> message) async {
//        print("onResume: $message");
//      },
    );

    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(
            sound: true, badge: true, alert: true, provisional: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });

    _firebaseMessaging.getToken().then((String token)async {
      if( token != null) {
        final SharedPreferences sharedPrefs = await SharedPreferences
            .getInstance();
        sharedPrefs.setString("FIREBASE_TOKEN_KEY", token);
      }
      print('Push Messaging token: $token');

    });
  }
}

Future<String> getFirebaseToken( ) async{
  final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
  return sharedPrefs.getString("FIREBASE_TOKEN_KEY");
}

Future<void> save(Map<String, dynamic> message) async{
  var body = json.encode(message);
  print('Message $body');
}