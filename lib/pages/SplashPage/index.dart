import 'package:geogo/constants/theme.dart';
import 'package:geogo/pages/LoginPage/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geogo/widgets/TabBar/index.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geogo/main.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 1), () {
      _pageHandler(context);
    });
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        body: Center(
          child: Padding(
              padding: const EdgeInsets.all(48),
              child: SvgPicture.asset(
                "assets/images/logo.svg",
              )),
        ),
        backgroundColor: themeData.backgroundColor,
      ),
    );
  }

  Future<void> _pageHandler(context) async {
    FirebaseAuth.instance.authStateChanges().listen((user) async {
      try {
        if (user == null) {
          _navigateToLoginPage(context);
          return;
        }
        _navigateToHomePage(context);
      } catch (e) {
        print(e);
      }
    });
  }

  _navigateToLoginPage(context) {
    navigatorKey.currentState?.pushReplacement(
        CupertinoPageRoute(builder: (context) => const LoginPage()));
  }

  _navigateToHomePage(context) {
    // print(firebase_observer.runtimeType);
    // print("##################");
    navigatorKey.currentState?.pushReplacement(
        CupertinoPageRoute(builder: (context) => TabBarApp()));
  }
}
