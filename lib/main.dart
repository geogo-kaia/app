import 'package:geogo/constants/theme.dart';
import 'package:geogo/pages/SplashPage/index.dart';
import 'package:geogo/widgets/TabBar/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:geogo/widgets/Provider/index.dart';
import 'package:geogo/services/auth.dart';

final navigatorKey = new GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final _initialization = await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Provider(
        auth: AuthService(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'BunnyGo',
          theme: themeData,
          navigatorKey: navigatorKey,
          home: SplashPage(),
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case '/':
                return CupertinoPageRoute(
                    builder: (context) => const TabBarApp());
              case 'HomePage':
                return CupertinoPageRoute(
                    builder: (context) => const TabBarApp());
              case 'SplashPage':
                return CupertinoPageRoute(
                    builder: (context) => const SplashPage());
              default:
                break;
            }
            return null;
          },
        ));
  }
}
