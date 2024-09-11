import 'package:geogo/constants/text_style.dart';
import 'package:geogo/constants/theme.dart';
import 'package:geogo/pages/ConfirmSeedPhrasePage/index.dart';
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

class SeedPhrasePage extends StatefulWidget {
  const SeedPhrasePage({
    Key? key,
  }) : super(key: key);

  @override
  State<SeedPhrasePage> createState() => _SeedPhrasePageState();
}

class _SeedPhrasePageState extends State<SeedPhrasePage> {
  String mnemonic = '';
  String walletAddress = '';
  String privateKey = '';

  @override
  void initState() {
    super.initState();
    createWallet();
  }

  /*  BIP32 Ethereum HD Wallet */
  /*  https://gist.github.com/Ankarrr/d82b49bbb481bf3181274cfd71b30bcc */
  void createWallet() async {
    String randomMnemonic = bip39.generateMnemonic();
    final seed = bip39.mnemonicToSeed(randomMnemonic);
    final root = bip32.BIP32.fromSeed(seed);
    String hdPath = "m/44'/60'/0'/0/0";
    final firstChild = root.derivePath(hdPath);
    String privateKey = HEX.encode(firstChild.privateKey as List<int>);
    final credentials = EthPrivateKey.fromHex(privateKey);

    setState(() {
      mnemonic = randomMnemonic;
      privateKey = privateKey.toString();
      walletAddress = credentials.address.hex;
    });
  }

  List<Widget> generateSeedPhraseGrid() {
    return mnemonic
        .split(' ')
        .asMap()
        .entries
        .map((entry) => RawChip(
            elevation: 0,
            backgroundColor: themeData.backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(color: Colors.grey[300]!, width: 1),
            ),
            label: Text("${entry.key + 1}. ${entry.value}")))
        .toList();
  }

  @override
  Widget build(BuildContext rootContext) {
    return Scaffold(
        backgroundColor: themeData.backgroundColor,
        appBar: AppBar(title: Text('')),
        bottomSheet: Padding(
          padding: const EdgeInsets.only(left: 24, right: 24, bottom: 48),
          child: RoundButton(
              "Continue",
              themeData.primaryColor,
              () => {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) =>
                                ConfirmSeedPhrasePage(mnemonic: mnemonic)))
                  }),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          child: SafeArea(
            child: ListView(children: [
              SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text("Your Seed Phrase", style: headerTitleStyle),
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  "Write down these words in the right order and save them somewhere safe",
                  style: descriptionTextStyle,
                ),
              ),
              SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text('Public Address: \n${walletAddress}',
                    style: miniTextStyle),
              ),
              SizedBox(height: 32),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 8,
                runSpacing: 2,
                children: generateSeedPhraseGrid(),
              ),
              SizedBox(height: 48),
            ]),
          ),
        ));
  }
}
