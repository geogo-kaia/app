import 'dart:typed_data';

import 'package:geogo/helpers/ethereum/test_connector.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'package:walletconnect_qrcode_modal_dart/walletconnect_qrcode_modal_dart.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web3dart/crypto.dart';
import 'package:web3dart/web3dart.dart';

class WalletConnectEthereumCredentials extends CustomTransactionSender {
  WalletConnectEthereumCredentials({required this.provider});

  final EthereumWalletConnectProvider provider;

  @override
  Future<EthereumAddress> extractAddress() {
    // TODO: implement extractAddress
    throw UnimplementedError();
  }

  @override
  Future<String> sendTransaction(Transaction transaction) async {
    final hash = await provider.sendTransaction(
      from: transaction.from!.hex,
      to: transaction.to?.hex,
      data: transaction.data,
      gas: transaction.maxGas,
      gasPrice: transaction.gasPrice?.getInWei,
      value: transaction.value?.getInWei,
      nonce: transaction.nonce,
    );

    return hash;
  }

  @override
  Future<MsgSignature> signToSignature(Uint8List payload,
      {int? chainId, bool isEIP1559 = false}) {
    // TODO: implement signToSignature
    throw UnimplementedError();
  }

  @override
  // TODO: implement address
  EthereumAddress get address => throw UnimplementedError();

  @override
  MsgSignature signToEcSignature(Uint8List payload,
      {int? chainId, bool isEIP1559 = false}) {
    // TODO: implement signToEcSignature
    throw UnimplementedError();
  }
}

class EthereumTestConnector implements TestConnector {
  EthereumTestConnector() {
    _connector = WalletConnectQrCodeModal(
      connector: WalletConnect(
        bridge: 'https://bridge.walletconnect.org',
        clientMeta: const PeerMeta(
          // <-- Meta data of your app appearing in the wallet when connecting
          name: 'GeoGO',
          description: 'GeoGO - Go Economy',
          url: 'https://geogo.io',
          icons: [
            'https://gblobscdn.gitbook.com/spaces%2F-LJJeCjcLrr53DcT1Ml7%2Favatar.png?alt=media'
          ],
        ),
      ),
    );

    _provider = EthereumWalletConnectProvider(_connector.connector, chainId: 1);
  }

  @override
  Future<SessionStatus?> connect(BuildContext context) async {
    return await _connector.connect(context, chainId: 1);
  }

  @override
  void registerListeners(
    OnConnectRequest? onConnect,
    OnSessionUpdate? onSessionUpdate,
    OnDisconnect? onDisconnect,
  ) =>
      _connector.registerListeners(
        onConnect: onConnect,
        onSessionUpdate: onSessionUpdate,
        onDisconnect: onDisconnect,
      );

  @override
  Future<String?> sendTestingAmount({
    required String recipientAddress,
    required double amount,
  }) async {
    final sender =
        EthereumAddress.fromHex(_connector.connector.session.accounts[0]);
    final recipient = EthereumAddress.fromHex(address);

    final etherAmount = EtherAmount.fromUnitAndValue(
        EtherUnit.szabo, (amount * 1000 * 1000).toInt());

    final transaction = Transaction(
      to: recipient,
      from: sender,
      gasPrice: EtherAmount.inWei(BigInt.one),
      maxGas: 100000,
      value: etherAmount,
    );

    final credentials = WalletConnectEthereumCredentials(provider: _provider);

    // Sign the transaction
    try {
      final txBytes = await _ethereum.sendTransaction(credentials, transaction);
      return txBytes;
    } catch (e) {
      debugPrint('Error: $e');
    }

    // Kill the session
    // _connector.killSession();

    return null;
  }

  @override
  Future<void> openWalletApp() async => await _connector.openWalletApp();

  @override
  Future<double> getBalance() async {
    final address =
        EthereumAddress.fromHex(_connector.connector.session.accounts[0]);
    final amount = await _ethereum.getBalance(address);
    return amount.getValueInUnit(EtherUnit.ether).toDouble();
  }

  @override
  bool validateAddress({required String address}) {
    try {
      EthereumAddress.fromHex(address);
      return true;
    } catch (_) {
      return false;
    }
  }

  @override
  String get faucetUrl => 'https://faucet.dimensions.network/';

  @override
  String get address => _connector.connector.session.accounts[0];

  @override
  String get coinName => 'ETH';

  late final WalletConnectQrCodeModal _connector;
  late final EthereumWalletConnectProvider _provider;
  final _ethereum = Web3Client(
      'https://patient-misty-star.discover.quiknode.pro/2c64e8d252d8a8d25b8dbbe18b1c13a4eb807927/',
      Client());
}
