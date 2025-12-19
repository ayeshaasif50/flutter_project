// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool isLoading = false;

  void signupUser() async {
    String email = emailController.text.trim();
    String pass = passwordController.text.trim();
    String confirmPass = confirmPasswordController.text.trim();

    if (email.isEmpty || pass.isEmpty || confirmPass.isEmpty) {
      showMessage("Fill all fields!");
      return;
    }

    if (pass != confirmPass) {
      showMessage("Passwords do not match!");
      return;
    }

    try {
      setState(() => isLoading = true);

      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );

      showMessage("Signup Successful!");

      Navigator.pop(context); // Back to login

    } on FirebaseAuthException catch (e) {
      showMessage(e.message ?? "Error occurred");
    } finally {
      setState(() => isLoading = false);
    }
  }

  void showMessage(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text, style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.brown[700],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5EDE0),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ☕ Logo
                Center(
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/bg.png',
                        height: 150,
                      ),
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
                  "Sign Up",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown[700],
                  ),
                ),

                SizedBox(height: 20),

                // 📧 Email Field
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email, color: Colors.brown[700]),
                    hintText: "Email",
                    filled: true,
                    fillColor: Colors.brown[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                SizedBox(height: 15),

                // 🔐 Password Field
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock, color: Colors.brown[700]),
                    hintText: "Password",
                    filled: true,
                    fillColor: Colors.brown[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                SizedBox(height: 15),

                // 🔐 Confirm Password
                TextField(
                  controller: confirmPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock, color: Colors.brown[700]),
                    hintText: "Confirm Password",
                    filled: true,
                    fillColor: Colors.brown[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                SizedBox(height: 30),

                // 🚀 Signup Button
                Center(
                  child: ElevatedButton(
                    onPressed: isLoading ? null : signupUser,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown[700],
                      padding: EdgeInsets.symmetric(horizontal: 100, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: isLoading
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text(
                      "Sign Up",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),

                SizedBox(height: 25),

                // 🔙 Back to Login (Clickable Now)
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: RichText(
                      text: TextSpan(
                        text: "Already have an account? ",
                        style: TextStyle(color: Colors.brown[700]),
                        children: [
                          TextSpan(
                            text: "Login",
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
