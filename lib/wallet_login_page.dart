import 'package:flutter/material.dart';
import 'package:reown_appkit/reown_appkit.dart';

class WalletLoginPage extends StatefulWidget {
  const WalletLoginPage({super.key});

  @override
  State<WalletLoginPage> createState() => _WalletLoginPageState();
}

class _WalletLoginPageState extends State<WalletLoginPage> {
  ReownAppKitModal? _appKitModal;

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

    final appKitModal = ReownAppKitModal(
      context: context,
      appKit: appKit,
    );

    await appKitModal.init();

    setState(() {
      _appKitModal = appKitModal;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_appKitModal == null) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 24),
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.grey.shade900,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'ElectionX',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 80),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Let's get you connected",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    AppKitModalConnectButton(appKit: _appKitModal!),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
