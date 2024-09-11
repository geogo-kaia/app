import 'package:geogo/constants/theme.dart';
import 'package:geogo/pages/SplashPage/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeData.backgroundColor,
      appBar: AppBar(
          title: const Text('Find Checkpoints'),
          iconTheme: IconThemeData(
            color: Color.fromRGBO(128, 128, 128, 1), //change your color here
          )),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: ListView(shrinkWrap: true, children: [
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => const SplashPage()));
                },
                child: const Text("LOGIN"))
          ]),
        ),
      ),
    );
  }
}
