import 'package:geogo/constants/text_style.dart';
import 'package:geogo/constants/theme.dart';
import 'package:geogo/helpers/ethereum/ethereum_test_connector.dart';
import 'package:geogo/helpers/ethereum/test_connector.dart';
import 'package:geogo/pages/LoginPage/index.dart';
import 'package:geogo/pages/RegisterPage/index.dart';
import 'package:geogo/pages/WalletPage/index.dart';
import 'package:geogo/widgets/ActivityListBody/index.dart';
import 'package:geogo/widgets/Buttons/RoundButton/index.dart';
import 'package:geogo/widgets/CategoryListBody/index.dart';
import 'package:geogo/widgets/CombinedScrollView/index.dart';
import 'package:geogo/widgets/EventListBody/index.dart';
import 'package:geogo/widgets/Header/TitleHeader/index.dart';
import 'package:geogo/widgets/RichText/index.dart';
import 'package:geogo/widgets/SilverAppBarScrollView/index.dart';
import 'package:geogo/widgets/TabBar/index.dart';
import 'package:geogo/widgets/TextFields/RoundTextField/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web3dart/src/crypto/secp256k1.dart';
import 'package:web3dart/web3dart.dart';
import 'dart:typed_data';
import 'package:http/http.dart';

enum ConnectionState {
  disconnected,
  connecting,
  connected,
  connectionFailed,
  connectionCancelled,
}

class DemoPage extends StatefulWidget {
  const DemoPage();
  @override
  _DemoPageState createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  TestConnector connector = EthereumTestConnector();
  static const _networks = ['Ethereum (Ropsten)', 'Algorand (Testnet)'];
  ConnectionState _state = ConnectionState.disconnected;
  String? _networkName = _networks.first;

  @override
  void initState() {
    connector.registerListeners(
        // connected
        (session) => debugPrint('Connected: $session'),
        // session updated
        (response) => debugPrint('Session updated: $response'),
        // disconnected
        () {
      setState(() => _state = ConnectionState.disconnected);
      debugPrint('Disconnected');
    });
    super.initState();
  }

  void _openWalletPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => WalletPage(connector: connector),
      ),
    );
  }

  String _transactionStateToString({required ConnectionState state}) {
    switch (state) {
      case ConnectionState.disconnected:
        return 'Connect!';
      case ConnectionState.connecting:
        return 'Connecting';
      case ConnectionState.connected:
        return 'Session connected';
      case ConnectionState.connectionFailed:
        return 'Connection failed';
      case ConnectionState.connectionCancelled:
        return 'Connection cancelled';
    }
  }

  VoidCallback? _transactionStateToAction(BuildContext context,
      {required ConnectionState state}) {
    debugPrint('State: ${_transactionStateToString(state: state)}');
    switch (state) {
      // Progress, action disabled
      case ConnectionState.connecting:
        return null;
      case ConnectionState.connected:
        // Open new page
        return () => _openWalletPage();

      // Initiate the connection
      case ConnectionState.disconnected:
      case ConnectionState.connectionCancelled:
      case ConnectionState.connectionFailed:
        return () async {
          setState(() => _state = ConnectionState.connecting);
          try {
            final session = await connector.connect(context);
            if (session != null) {
              setState(() => _state = ConnectionState.connected);
              Future.delayed(Duration.zero, () => _openWalletPage());
            } else {
              setState(() => _state = ConnectionState.connectionCancelled);
            }
          } catch (e) {
            debugPrint('WC exception occured: $e');
            setState(() => _state = ConnectionState.connectionFailed);
          }
        };
    }
  }

  @override
  Widget build(BuildContext context) {
    // Transaction Flow
    return Scaffold(
        appBar: AppBar(
            title: Text(''),
            iconTheme: IconThemeData(
              color: Color.fromRGBO(128, 128, 128, 1), //change your color here
            )),
        body: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: themeData.primaryColor,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                      )),
                  onPressed: _transactionStateToAction(context, state: _state),
                  child: Text(
                    _transactionStateToString(state: _state),
                    style: buttonTextStyle,
                  )),
            ),
          ],
        )));
  }
}
