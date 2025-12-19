import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _currentController = TextEditingController();
  final _newController = TextEditingController();
  final _confirmController = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _currentController.dispose();
    _newController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Future<void> _changePassword() async {
    final user = FirebaseAuth.instance.currentUser;

    if (_formKey.currentState!.validate()) {
      setState(() => _loading = true);

      try {
        // Re-authenticate user
        final credential = EmailAuthProvider.credential(
          email: user!.email!,
          password: _currentController.text,
        );
        await user.reauthenticateWithCredential(credential);

        // Update password
        await user.updatePassword(_newController.text);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Password updated successfully')),
        );
        Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message ?? 'Error updating password')),
        );
      } finally {
        setState(() => _loading = false);
      }
    }
  }

  InputDecoration _buildInputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.brown[50],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5EDE0),
      appBar: AppBar(
        title: const Text('Change Password'),
        backgroundColor: const Color(0xFF8C6542),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "Update your password",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF8C6542),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 25),

              // Current Password
              TextFormField(
                controller: _currentController,
                obscureText: true,
                decoration: _buildInputDecoration('Current Password'),
                validator: (val) =>
                val == null || val.isEmpty ? 'Enter current password' : null,
              ),
              const SizedBox(height: 16),

              // New Password
              TextFormField(
                controller: _newController,
                obscureText: true,
                decoration: _buildInputDecoration('New Password'),
                validator: (val) {
                  if (val == null || val.isEmpty) return 'Enter new password';
                  if (val.length < 6) return 'Password must be at least 6 chars';
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Confirm Password
              TextFormField(
                controller: _confirmController,
                obscureText: true,
                decoration: _buildInputDecoration('Confirm New Password'),
                validator: (val) =>
                val != _newController.text ? 'Passwords do not match' : null,
              ),
              const SizedBox(height: 30),

              // Change Password Button
              ElevatedButton(
                onPressed: _loading ? null : _changePassword,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8C6542),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: _loading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                  'Change Password',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Center(
                child: Text(
                  "☕ Coffee Enyong — Stay secure!",
                  style: TextStyle(
                    color: Colors.brown[400],
                    fontSize: 13,
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
