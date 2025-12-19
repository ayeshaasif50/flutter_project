// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bgColor = theme.scaffoldBackgroundColor;
    final primaryColor = theme.colorScheme.primary;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: const Text(
          "About Us",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: primaryColor,
        elevation: 4,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Logo / Online Image
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundColor: primaryColor.withOpacity(0.3),
                backgroundImage: NetworkImage(
                  'https://images.pexels.com/photos/45201/kitty-cat-kitten-pet-45201.jpeg',
                ),
              ),
            ),
            const SizedBox(height: 20),

            // App Name
            Text(
              "Coffee Enyong ☕",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            const SizedBox(height: 10),

            // Short Description
            Text(
              "Your cozy coffee companion — serving happiness, warmth, and freshly brewed perfection.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: theme.textTheme.bodyMedium!.color,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 30),

            // Mission Card
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              elevation: 3,
              color: primaryColor.withOpacity(0.1),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Our Mission",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: primaryColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "To bring the joy of coffee to everyone — one cup at a time. "
                          "We believe coffee is not just a drink, it's a moment of peace, comfort, and connection.",
                      style: TextStyle(
                        fontSize: 15,
                        color: theme.textTheme.bodyMedium!.color,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Vision Card
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              elevation: 3,
              color: primaryColor.withOpacity(0.1),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Our Vision",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: primaryColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "To become the most loved and sustainable coffee brand, "
                          "spreading smiles and caffeine-powered creativity everywhere.",
                      style: TextStyle(
                        fontSize: 15,
                        color: theme.textTheme.bodyMedium!.color,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Contact Info Card
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              elevation: 3,
              color: primaryColor.withOpacity(0.05),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Contact Us",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: primaryColor,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.email, color: primaryColor),
                      title: const Text("support@coffeeenyong.com"),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.phone, color: primaryColor),
                      title: const Text("+92 300 1234567"),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.location_on, color: primaryColor),
                      title: const Text("Coffee Street, Sahiwal, Pakistan"),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 25),

            // Social Media Row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                socialIcon(Icons.facebook, primaryColor, "Facebook"),
                const SizedBox(width: 20),
                socialIcon(Icons.camera_alt, primaryColor, "Instagram"),
                const SizedBox(width: 20),
                socialIcon(Icons.alternate_email, primaryColor, "Twitter"),
              ],
            ),
            const SizedBox(height: 35),

            // Footer
            Text(
              "© 2025 Coffee Enyong. All Rights Reserved.",
              style: TextStyle(
                color: theme.textTheme.bodySmall!.color,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Social icon helper
  Widget socialIcon(IconData icon, Color color, String platform) {
    return InkWell(
      onTap: () {
        // TODO: Add actual social links
      },
      borderRadius: BorderRadius.circular(30),
      child: CircleAvatar(
        radius: 22,
        backgroundColor: color,
        child: Icon(icon, color: Colors.white),
      ),
    );
  }
}
