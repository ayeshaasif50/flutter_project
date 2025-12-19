// ignore_for_file: prefer_const_constructors

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'signup_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  // --- GOOGLE SIGN-IN (Web + Mobile) ---
  Future<UserCredential> signInWithGoogle() async {
    if (kIsWeb) {
      GoogleAuthProvider googleProvider = GoogleAuthProvider();
      googleProvider.addScope('https://www.googleapis.com/auth/userinfo.email');
      return await FirebaseAuth.instance.signInWithPopup(googleProvider);
    } else {
      final GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);
      await googleSignIn.signOut(); // Clear old session
      final GoogleSignInAccount? account = await googleSignIn.signIn();

      if (account == null) throw Exception('Google sign-in aborted');

      final auth = await account.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: auth.accessToken,
        idToken: auth.idToken,
      );

      return await FirebaseAuth.instance.signInWithCredential(credential);
    }
  }

  // --- GITHUB SIGN-IN ---
  Future<UserCredential> signInWithGitHub() async {
    GithubAuthProvider githubProvider = GithubAuthProvider();
    return await FirebaseAuth.instance.signInWithPopup(githubProvider);
  }

  // --- APPLE SIGN-IN ---
  Future<UserCredential> signInWithApple() async {
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );

    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: credential.identityToken,
      accessToken: credential.authorizationCode,
    );

    return await FirebaseAuth.instance.signInWithCredential(oauthCredential);
  }

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    void showSnackBar(String message) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message, style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.brown[700],
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF5EDE0),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      Image.asset('assets/bg.png', height: 150),
                      SizedBox(height: 15),
                      Text(
                        "Coffee Enyong",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown[800],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 40),

                Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown[700],
                  ),
                ),

                SizedBox(height: 20),

                // Email Field
                TextField(
                  controller: emailController,
                  style: TextStyle(color: Colors.brown[800]), // typed text
                  cursorColor: Colors.brown[700],
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email, color: Colors.brown[700]),
                    hintText: "Email",
                    hintStyle: TextStyle(color: Colors.brown[500]), // placeholder
                    filled: true,
                    fillColor: Colors.brown[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                SizedBox(height: 15),

                // Password Field
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  style: TextStyle(color: Colors.brown[800]), // typed text
                  cursorColor: Colors.brown[700],
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock, color: Colors.brown[700]),
                    hintText: "Password",
                    hintStyle: TextStyle(color: Colors.brown[500]), // placeholder
                    filled: true,
                    fillColor: Colors.brown[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () async {
                      String email = emailController.text.trim();
                      if (email.isEmpty) {
                        showSnackBar("Please enter your email");
                        return;
                      }
                      try {
                        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
                        showSnackBar("Password reset email sent!");
                      } catch (e) {
                        showSnackBar(e.toString());
                      }
                    },
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                        color: Colors.brown[700],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20),

                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      String email = emailController.text.trim();
                      String password = passwordController.text.trim();
                      try {
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: email,
                          password: password,
                        );
                        Navigator.pushReplacementNamed(context, '/home');
                      } catch (e) {
                        showSnackBar(e.toString());
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown[700],
                      padding: EdgeInsets.symmetric(horizontal: 100, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      "Login",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),

                SizedBox(height: 25),

                // Social Login Row
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Google
                      IconButton(
                        onPressed: () async {
                          try {
                            await signInWithGoogle();
                            Navigator.pushReplacementNamed(context, '/home');
                          } catch (e) {
                            showSnackBar(e.toString());
                          }
                        },
                        icon: Image.asset('assets/img_33.png', height: 30),
                      ),
                      SizedBox(width: 20),

                      // GitHub
                      IconButton(
                        onPressed: () async {
                          try {
                            await signInWithGitHub();
                            Navigator.pushReplacementNamed(context, '/home');
                          } catch (e) {
                            showSnackBar(e.toString());
                          }
                        },
                        icon: Image.asset('assets/img_36.png', height: 30),
                      ),
                      SizedBox(width: 20),

                      // Apple
                      IconButton(
                        onPressed: () async {
                          try {
                            await signInWithApple();
                            Navigator.pushReplacementNamed(context, '/home');
                          } catch (e) {
                            showSnackBar(e.toString());
                          }
                        },
                        icon: Image.asset('assets/img_35.png', height: 30),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 25),

                // Signup link
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignupPage()),
                      );
                    },
                    child: RichText(
                      text: TextSpan(
                        text: "Don't have an account? ",
                        style: TextStyle(color: Colors.brown[700]),
                        children: [
                          TextSpan(
                            text: "Sign Up",
                            style: TextStyle(
                              color: Colors.brown[900],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
