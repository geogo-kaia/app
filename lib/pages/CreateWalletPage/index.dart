import 'package:geogo/constants/theme.dart';
import 'package:geogo/pages/SeedPhrasePage/index.dart';
import 'package:geogo/widgets/Buttons/RoundButton/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class CreateWalletPage extends StatefulWidget {
  const CreateWalletPage({
    Key? key,
  }) : super(key: key);

  @override
  State<CreateWalletPage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreateWalletPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext rootContext) {
    return Scaffold(
        backgroundColor: themeData.backgroundColor,
        appBar: AppBar(title: Text('')),
        body: SafeArea(
            child: ListView(children: [
          SizedBox(height: 64),
          Image.asset(
            "assets/images/wallet_illustration.png",
            width: MediaQuery.of(context).size.width * 0.3,
            alignment: Alignment.centerLeft,
          ),
          SizedBox(height: 48),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
            child: RoundButton(
                "Create a new wallet",
                themeData.primaryColor,
                () => {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => SeedPhrasePage()),
                      )
                    }),
          ),
          SizedBox(height: 48),
        ])));
  }
}
