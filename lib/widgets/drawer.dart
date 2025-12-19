// ignore_for_file: prefer_const_constructors  // ⚙️ Ignore constant constructor warning

import 'package:flutter/material.dart';  // 📦 Import Flutter material package
import '../main.dart'; // 🔗 Import main.dart to access global variables

class AppDrawer extends StatelessWidget { // 🧱 Custom drawer widget class
  const AppDrawer({super.key}); // 🗝️ Constructor

  @override
  Widget build(BuildContext context) { // 🧩 Build method (UI banata hai)
    return Drawer( // 🪟 Drawer widget (side menu)
      backgroundColor: const Color(0xFFF5EDE0), // 🎨 Drawer background color
      child: ListView( // 📜 Scrollable list inside drawer
        padding: EdgeInsets.zero, // 🚫 No padding at top
        children: [ // 👇 Drawer ke andar ye widgets aayenge

          // ☕ Drawer Header (Top section)
          DrawerHeader(
            decoration: const BoxDecoration(color: Color(0xFF8C6542)), // 🎨 Brown background
            child: Column( // 📦 Arrange widgets vertically
              crossAxisAlignment: CrossAxisAlignment.start, // 👈 Align items to left
              children: [
                CircleAvatar( // 👤 Circular area for logo
                  radius: 32, // 🔵 Circle size
                  backgroundColor: Colors.white, // ⚪ White background
                  child: ClipOval( // ✂️ Make image circular
                    child: Image.asset( // 🖼️ Load image from assets
                      'assets/coffee_logo.png', // 📂 Image path
                      fit: BoxFit.cover, // 🧩 Fit image properly
                      width: 60, // 📏 Image width
                      height: 60, // 📐 Image height
                    ),
                  ),
                ),
                const SizedBox(height: 10), // ⬇️ Space between logo and text
                const Text( // 📝 App name text
                  "Coffee Enyong", // ☕ App title
                  style: TextStyle( // 🎨 Text styling
                    color: Colors.white, // ⚪ White text
                    fontSize: 22, // 🔠 Font size
                    fontWeight: FontWeight.bold, // 💪 Bold text
                    letterSpacing: 1.2, // ✍️ Space between letters
                  ),
                ),
                const Text( // 📄 Tagline text
                  "Freshly brewed happiness", // 😊 Tagline
                  style: TextStyle(color: Colors.white70, fontSize: 12), // 🎨 Light white color
                ),
              ],
            ),
          ),

          // 🏠 Drawer menu items list below header
          _buildDrawerItem(Icons.home_filled, "Home", context), // 🏡 Home button
          _buildDrawerItem(Icons.local_cafe, "Menu", context), // ☕ Menu page
          _buildDrawerItem(Icons.favorite, "Favorites", context), // ❤️ Favorites page
          _buildDrawerItem(Icons.shopping_cart, "My Cart", context), // 🛒 Cart page
          _buildDrawerItem(Icons.person, "Profile", context), // 👤 Profile page
          _buildDrawerItem(Icons.history, "Order History", context), // 📜 Order history
          _buildDrawerItem(Icons.settings, "Settings", context), // ⚙️ Settings page
          _buildDrawerItem(Icons.info_outline, "About Us", context), // ℹ️ About page
          const Divider(), // ➖ Line separator
          _buildDrawerItem(Icons.logout, "Logout", context, color: Colors.redAccent), // 🚪 Logout option
        ],
      ),
    );
  }

  // 📦 Helper method to create each drawer item easily
  Widget _buildDrawerItem(IconData icon, String title, BuildContext context, {Color? color}) {
    return ListTile( // 🧩 List tile for each drawer option
      leading: Icon(icon, color: color ?? const Color(0xFF8C6542)), // 🎨 Icon on left
      title: Text( // 📝 Menu text
        title, // 🔤 Title text (like Home, Menu, etc.)
        style: TextStyle(
          color: color ?? const Color(0xFF8C6542), // 🎨 Text color
          fontWeight: FontWeight.w500, // 💪 Medium bold
        ),
      ),
      onTap: () { // 👆 What happens on tap
        Navigator.pop(context); // 🚪 Close drawer first

        // 🔄 Navigate to specific page based on title
        switch (title) {
          case "Home": // 🏠 Go to Home page
            Navigator.pushReplacementNamed(context, '/home');
            break;
          case "Menu": // ☕ Go to Menu page
            Navigator.pushNamed(context, '/menu');
            break;
          case "Favorites": // ❤️ Go to Favorites page
            Navigator.pushNamed(context, '/favorites');
            break;
          case "My Cart": // 🛒 Go to Cart page
            Navigator.pushNamed(context, '/cart');
            break;
          case "Profile": // 👤 Go to Profile page
            Navigator.pushNamed(context, '/profile');
            break;
          case "Order History": // 📜 Go to Order History page
            Navigator.pushNamed(context, '/orderHistory');
            break;
          case "Settings": // ⚙️ Go to Settings page
            Navigator.pushNamed(context, '/settings');
            break;
          case "About Us": // ℹ️ Go to About page
            Navigator.pushNamed(context, '/about');
            break;
          case "Logout": // 🚪 Log out and go to login page
            Navigator.pushReplacementNamed(context, '/login');
            break;
        }
      },
    );
  }
}
