import 'package:flutter/material.dart';
import 'package:reown_appkit/reown_appkit.dart';

class WalletLoginPage extends StatefulWidget {
  const WalletLoginPage({super.key});

  @override
  State<WalletLoginPage> createState() => _WalletLoginPageState();
}

class _WalletLoginPageState extends State<WalletLoginPage> {
  late final ReownAppKitModal _appKitModal;

  @override
  void initState() {
    super.initState();
    _initializeAppKit();
  }

  Future<void> _initializeAppKit() async {
    final appKit = await ReownAppKit.createInstance(
      projectId: '47a573f8635bdc22adf4030bdca85210',
      metadata: const PairingMetadata(
        name: 'ElectionX',
        description: 'Voting app using MetaMask login',
        url: 'https://github.com',
        icons: [
          'https://raw.githubusercontent.com/MetaMask/brand-resources/master/SVG/metamask-fox.svg',
        ],
      ),
    );

    _appKitModal = ReownAppKitModal(
      context: context,
      appKit: appKit,
    );

    await _appKitModal.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Connect Wallet')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppKitModalConnectButton(appKit: _appKitModal),
            const SizedBox(height: 20),
            AppKitModalAccountButton(appKitModal: _appKitModal),
          ],
        ),
      ),
    );
  }
}
