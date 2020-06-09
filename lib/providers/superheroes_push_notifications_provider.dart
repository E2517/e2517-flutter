import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:async';

class PushNotificationsProvider {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final _messagesController = StreamController<dynamic>.broadcast();
  Stream<dynamic> get messages => _messagesController.stream;

  initNotifications() {
    _firebaseMessaging.requestNotificationPermissions();

    _firebaseMessaging.getToken().then((token) {
      print('=================== FCM TOKEN MOBILE ===================');
      print(token);
    });

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");

        dynamic data;

        data = message['data']['name'] +
                ' ' +
                message['data']['points'] +
                ' ' +
                message['data']['available'] ??
            'no-data';

        _messagesController.sink.add(data);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");

        dynamic data;

        data = message['data']['name'] +
                ' ' +
                message['data']['points'] +
                ' ' +
                message['data']['available'] ??
            'no-data';
        _messagesController.sink.add(data);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");

        dynamic data;

        data = message['data']['name'] +
                ' ' +
                message['data']['points'] +
                ' ' +
                message['data']['available'] ??
            'no-data';
        _messagesController.sink.add(data);
      },
    );
  }

  dispose() {
    _messagesController?.close();
  }
}
