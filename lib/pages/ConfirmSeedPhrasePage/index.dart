import 'package:geogo/constants/text_style.dart';
import 'package:geogo/constants/theme.dart';
import 'package:geogo/pages/HomePage/index.dart';
import 'package:geogo/pages/LoginPage/index.dart';
import 'package:geogo/pages/ProfilePage/index.dart';
import 'package:geogo/widgets/Buttons/RoundButton/index.dart';
import 'package:geogo/widgets/TabBar/index.dart';
import 'package:flutter/material.dart';
import 'package:web3dart/web3dart.dart';
import 'package:hex/hex.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:bip32/bip32.dart' as bip32;
import 'package:flutter/cupertino.dart';

class ConfirmSeedPhrasePage extends StatefulWidget {
  final String mnemonic;
  const ConfirmSeedPhrasePage({required this.mnemonic});

  @override
  State<ConfirmSeedPhrasePage> createState() => _ConfirmSeedPhrasePageState();
}

class _ConfirmSeedPhrasePageState extends State<ConfirmSeedPhrasePage> {
  late List<String> shuffledMnemonic = widget.mnemonic.split(' ');
  List<String> seedPhrase = [];
  late Map<String, bool> showWords = {};
  @override
  void initState() {
    super.initState();
    shuffledMnemonic.shuffle();
    for (int i = 0; i < shuffledMnemonic.length; i++) {
      showWords[shuffledMnemonic[i].toString()] = true;
    }
    print(showWords);
  }

  void showHide(String key) {
    setState(() {
      showWords[key] = !(showWords[key])!;
    });
  }

  bool checkListsEqual(var list1, var list2) {
    // check if both are lists
    if (!(list1 is List && list2 is List)
        // check if both have same length
        ||
        list1.length != list2.length) {
      return false;
    }

    // check if elements are equal
    for (int i = 0; i < list1.length; i++) {
      if (list1[i] != list2[i]) {
        return false;
      }
    }
    return true;
  }

  List<Widget> generateAnswerGrid() {
    return seedPhrase
        .asMap()
        .entries
        .map((entry) => InkWell(
            onTap: () {
              setState(() {
                showHide(entry.value);
                seedPhrase.removeWhere((str) {
                  return str == entry.value;
                });
              });
            },
            child: RawChip(
                elevation: 0,
                backgroundColor: themeData.backgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(color: Colors.grey[300]!, width: 1),
                ),
                label: Text("${entry.key + 1}. ${entry.value}"))))
        .toList();
  }

  List<Widget> generateRandomSeedGrid() {
    return shuffledMnemonic
        .asMap()
        .entries
        .map((entry) => Opacity(
            opacity: (showWords[entry.value]) == true ? 1 : 0,
            child: InkWell(
                onTap: () {
                  (showWords[entry.value]) == true
                      ? setState(() {
                          showHide(entry.value);
                          seedPhrase.add(entry.value);
                        })
                      : null;
                },
                child: RawChip(
                    elevation: 0,
                    backgroundColor: themeData.backgroundColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: Colors.grey[300]!, width: 1),
                    ),
                    label: Text(entry.value)))))
        .toList();
  }

  @override
  Widget build(BuildContext rootContext) {
    return Scaffold(
        backgroundColor: themeData.backgroundColor,
        appBar: AppBar(title: Text('')),
        bottomSheet: Padding(
          padding: const EdgeInsets.only(left: 24, right: 24, bottom: 48),
          child: RoundButton("Confirm", themeData.primaryColor, () {
            List<String> correctMnemonic = widget.mnemonic.split(' ');
            if (checkListsEqual(correctMnemonic, seedPhrase))
              Navigator.push(context,
                  CupertinoPageRoute(builder: (context) => ProfilePage()));
          }),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          child: SafeArea(
            child: ListView(children: [
              SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text("Verify Secret Phrase", style: headerTitleStyle),
              ),
              SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  "Tap the words to re-arrange the order.",
                  style: descriptionTextStyle,
                ),
              ),
              Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                  margin: EdgeInsets.symmetric(vertical: 16),
                  color: Colors.grey[300],
                  width: double.infinity,
                  height: 220,
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 8,
                    runSpacing: 2,
                    children: generateAnswerGrid(),
                  )),
              SizedBox(height: 32),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 8,
                runSpacing: 2,
                children: generateRandomSeedGrid(),
              ),
              SizedBox(height: 48),
            ]),
          ),
        ));
  }
}
