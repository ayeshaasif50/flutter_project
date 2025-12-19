// ignore_for_file: prefer_const_constructors  // ⚙️ Ignore constant constructor warnings

import 'package:flutter/material.dart';
import '../main.dart'; // 👈 IMPORT AUTHGATE (IMPORTANT)

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5EDE0),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ☕ Coffee cup logo
            Image.asset(
              'assets/logo.png',
              height: 130,
            ),

            const SizedBox(height: 20),

            // App Name
            Text(
              'Coffee Enyong ☕',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.brown[800],
                letterSpacing: 1.2,
              ),
            ),

            const SizedBox(height: 60),

            // 3 Dots Loading Indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                _SplashDot(isActive: true),
                _SplashDot(isActive: false),
                _SplashDot(isActive: false),
              ],
            ),

            const SizedBox(height: 60),

            // ⭐ Continue Button → AuthGate
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AuthGate(), // 👈 UPDATED HERE!!
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown[700],
                padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 3,
              ),
              child: const Text(
                "Continue",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 🔸 Dot Widget for splash indicator
class _SplashDot extends StatelessWidget {
  final bool isActive;
  const _SplashDot({required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      width: isActive ? 10 : 8,
      height: isActive ? 10 : 8,
      decoration: BoxDecoration(
        color: isActive ? Colors.brown[800] : Colors.brown[300],
        shape: BoxShape.circle,
      ),
    );
  }
}
