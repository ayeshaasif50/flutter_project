// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

// 📂 Screens
import 'screens/splash_page.dart';
import 'screens/login_page.dart';
import 'screens/home_page.dart';
import 'screens/menu_page.dart';
import 'screens/menu_detail_page.dart';
import 'screens/favorites_page.dart';
import 'screens/cart_page.dart';
import 'screens/profile_page.dart';
import 'screens/order_history_page.dart';
import 'screens/settings_page.dart';
import 'screens/about_page.dart';
import 'screens/change_password_page.dart';

// 💙 Global lists
List<Map<String, String>> globalFavorites = [];
List<Map<String, dynamic>> globalCart = [];
List<Map<String, dynamic>> globalOrders = [];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Load saved dark mode preference before app runs
  final prefs = await SharedPreferences.getInstance();
  bool isDarkMode = prefs.getBool('darkMode') ?? false;

  runApp(MyApp(isDarkMode: isDarkMode));
}

class MyApp extends StatefulWidget {
  final bool isDarkMode;

  const MyApp({super.key, required this.isDarkMode});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late bool _isDarkMode;

  @override
  void initState() {
    super.initState();
    _isDarkMode = widget.isDarkMode;
  }

  // Toggle dark mode dynamically
  void toggleDarkMode(bool value) async {
    setState(() {
      _isDarkMode = value;
    });
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('darkMode', value);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coffee Enyong ☕',
      debugShowCheckedModeBanner: false,

      // Theme configuration
      theme: ThemeData(
        brightness: Brightness.light,
        fontFamily: 'Poppins',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
        scaffoldBackgroundColor: Color(0xFFF5EDE0),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF8C6542),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.brown, brightness: Brightness.dark),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.brown[800],
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        useMaterial3: true,
      ),
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,

      // ⭐ Show splash screen first
      home: SplashWrapper(),

      // All routes
      routes: {
        '/login': (context) => LoginPage(),
        '/home': (context) => HomePage(),
        '/menu': (context) => MenuPage(),
        '/menuDetail': (context) => MenuDetailPage(
          item: {'name': '', 'image': '', 'price': '', 'desc': ''},
        ),
        '/favorites': (context) => FavoritesPage(),
        '/cart': (context) => CartPage(cartItems: globalCart),
        '/profile': (context) => ProfilePage(),
        '/orderHistory': (context) => OrderHistoryPage(),
        '/settings': (context) => SettingsPage(
          toggleDarkMode: toggleDarkMode,
          isDarkMode: _isDarkMode,
        ),
        '/about': (context) => AboutPage(),
        '/changePassword': (context) => ChangePasswordPage(),
      },
    );
  }
}

// ⭐⭐ SPLASH WRAPPER — Always show splash first
class SplashWrapper extends StatefulWidget {
  @override
  _SplashWrapperState createState() => _SplashWrapperState();
}

class _SplashWrapperState extends State<SplashWrapper> {
  @override
  void initState() {
    super.initState();

    // ⏳ 3 sec delay → then go to AuthGate
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => AuthGate()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SplashPage(); // Always show splash first
  }
}

// ⭐⭐ AUTH GATE — Auto Route Based on Login Status
class AuthGate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SplashPage(); // Temporary splash
        }

        if (snapshot.hasData) {
          return HomePage(); // User logged in
        }

        return LoginPage(); // Not logged in
      },
    );
  }
}

