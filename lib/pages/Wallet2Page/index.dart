import 'package:geogo/constants/text_style.dart';
import 'package:geogo/constants/theme.dart';
import 'package:geogo/helpers/ethereum/test_connector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math'; //used for the random number generator
import 'package:web3dart/web3dart.dart';
import 'package:hex/hex.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:bip32/bip32.dart' as bip32;
import 'package:ed25519_hd_key/ed25519_hd_key.dart';

class Wallet2Page extends StatefulWidget {
  const Wallet2Page({
    Key? key,
  }) : super(key: key);

  @override
  State<Wallet2Page> createState() => _Wallet2PageState();
}

class _Wallet2PageState extends State<Wallet2Page> {
  final addressController = TextEditingController();
  final amountController = TextEditingController();
  String walletAddress = '';
  String privateKey = '';
  String mnemonic = '';
  bool validateAddress = true;
  bool validateAmount = true;

  @override
  void dispose() {
    addressController.dispose();
    amountController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  /*  BIP32 Ethereum HD Wallet */
  /*  https://gist.github.com/Ankarrr/d82b49bbb481bf3181274cfd71b30bcc */
  void createWallet() async {
    String randomMnemonic = bip39.generateMnemonic();
    final seed = bip39.mnemonicToSeed(randomMnemonic);
    final root = bip32.BIP32.fromSeed(seed);
    String hdPath = "m/44'/60'/0'/0/0";
    final firstChild = root.derivePath(hdPath);
    String private_key = HEX.encode(firstChild.privateKey as List<int>);
    final credentials = EthPrivateKey.fromHex(private_key);

    setState(() {
      mnemonic = randomMnemonic;
      privateKey = private_key.toString();
      walletAddress = credentials.address.hex;
      debugPrint("mnemonic:$mnemonic");
      debugPrint("privateKey:$privateKey");
      debugPrint("walletAddress:$walletAddress");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeData.backgroundColor,
      appBar: AppBar(
          title: Text(''),
          iconTheme: IconThemeData(
            color: Color.fromRGBO(128, 128, 128, 1), //change your color here
          )),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(privateKey),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(mnemonic),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(walletAddress),
                ),
                TextButton(onPressed: createWallet, child: const Text("CREATE"))
              ])),
        ),
      ),
    );
  }
}
