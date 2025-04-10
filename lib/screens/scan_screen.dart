import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  MobileScannerController controller = MobileScannerController();
  String? result;

  @override
  void initState() {
    super.initState();
    _requestCameraPermission();
  }

  Future<void> _requestCameraPermission() async {
    if (await Permission.camera.request().isGranted) {
      setState(() {});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Camera permission denied')),
      );
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _showResultDialog(String scannedResult) {
    showDialog(
      context: context,
      builder: (context) {
        final themeProvider = Provider.of<ThemeProvider>(context);
        return AlertDialog(
          backgroundColor: themeProvider.themeData.cardColor,
          title: Text(
            'Scan Result',
            style: TextStyle(color: themeProvider.themeData.textTheme.bodyLarge!.color),
          ),
          content: Text(
            scannedResult,
            style: TextStyle(color: themeProvider.themeData.textTheme.bodyMedium!.color),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                controller.start();
              },
              child: Text(
                'OK',
                style: TextStyle(color: themeProvider.themeData.textTheme.bodyMedium!.color),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: themeProvider.themeData.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Scan QR Code'),
        backgroundColor: themeProvider.themeData.scaffoldBackgroundColor,
        foregroundColor: themeProvider.themeData.textTheme.bodyLarge!.color,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: MobileScanner(
              controller: controller,
              onDetect: (BarcodeCapture capture) {
                final List<Barcode> barcodes = capture.barcodes;
                if (barcodes.isNotEmpty) {
                  final String? code = barcodes.first.rawValue;
                  if (code != null) {
                    setState(() {
                      result = code;
                    });
                    controller.stop();
                    _showResultDialog(code);
                  }
                }
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                result != null ? 'Result: $result' : 'Scan a QR code',
                style: TextStyle(
                  color: themeProvider.themeData.textTheme.bodyMedium!.color,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}