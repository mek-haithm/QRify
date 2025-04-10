import 'package:flutter/material.dart';
import 'package:neopop/widgets/buttons/neopop_button/neopop_button.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import 'scan_screen.dart';
import 'generate_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;

    return Scaffold(
      backgroundColor: themeProvider.themeData.scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'QR Code Master',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.grey[100] : Colors.grey[900],
                ),
              ),
              const SizedBox(height: 40),
              NeoPopButton(
                color: themeProvider.themeData.cardColor,
                onTapUp: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ScanScreen()),
                  );
                },
                onTapDown: () {},
                shadowColor: isDark ? Colors.black54 : Colors.grey[400]!,
                depth: 5,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.qr_code_scanner, color: isDark ? Colors.grey[300] : Colors.grey[700]),
                      const SizedBox(width: 10),
                      Text(
                        'Scan QR Code',
                        style: TextStyle(
                          fontSize: 18,
                          color: isDark ? Colors.grey[300] : Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              NeoPopButton(
                color: themeProvider.themeData.cardColor,
                onTapUp: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const GenerateScreen()),
                  );
                },
                onTapDown: () {},
                shadowColor: isDark ? Colors.black54 : Colors.grey[400]!,
                depth: 5,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.qr_code, color: isDark ? Colors.grey[300] : Colors.grey[700]),
                      const SizedBox(width: 10),
                      Text(
                        'Generate QR Code',
                        style: TextStyle(
                          fontSize: 18,
                          color: isDark ? Colors.grey[300] : Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              NeoPopButton(
                color: themeProvider.themeData.cardColor,
                onTapUp: () {
                  themeProvider.toggleTheme();
                },
                onTapDown: () {},
                shadowColor: isDark ? Colors.black54 : Colors.grey[400]!,
                depth: 5,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Icon(
                    isDark ? Icons.light_mode : Icons.dark_mode,
                    color: isDark ? Colors.grey[300] : Colors.grey[700],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}