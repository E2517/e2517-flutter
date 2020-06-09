import 'package:flutter/material.dart';
import 'package:e2517/bloc/provider_bloc.dart';
import 'package:e2517/views/login_views.dart';
import 'package:e2517/views/registration_views.dart';
import 'package:e2517/views/superheroes_views.dart';
import 'package:e2517/views/info_register_views.dart';
import 'package:e2517/views/info_push_notifications_views.dart';
import 'package:e2517/views/404_views.dart';
import 'package:e2517/preferences/shared_preferences.dart';
import 'package:e2517/providers/superheroes_push_notifications_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new UserPreferences();
  await prefs.initPrefs();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _pushNotifications = new PushNotificationsProvider();
  GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();

    setState(() {
      _pushNotifications.initNotifications();
      _pushNotifications.messages.listen((data) {
        print('Superheroe (data) from Firebase $data');
        navigatorKey.currentState
            .pushNamed('infoPushNotifications', arguments: data);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // final _prefs = new UserPreferences();
    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        navigatorKey: navigatorKey,
        title: 'Routes',
        initialRoute: 'login',
        routes: {
          'login': (BuildContext context) => LoginPage(),
          // 'login': (BuildContext context) =>
          //     _prefs.token != null ? UserPage() : LoginPage(),
          'registration': (BuildContext context) => RegistrationPage(),
          'user': (BuildContext context) => UserPage(),
          'info': (BuildContext context) => InfoPage(),
          'infoPushNotifications': (BuildContext context) =>
              InfoPushNotificationsPage(),
        },
        onUnknownRoute: (RouteSettings settings) =>
            MaterialPageRoute(builder: (context) => Page404()),
      ),
    );
  }
}
