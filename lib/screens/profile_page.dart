import 'dart:io';
import 'dart:typed_data';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart'; // Make sure globalCart & globalOrders are defined here

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _profileImage;
  Uint8List? _webImage;
  final ImagePicker _picker = ImagePicker();

  String _name = "Ayesha Asif";
  String _email = "ayesha.asif@example.com";
  String _contact = "0312-3456789";

  // Mock notifications
  List<Map<String, String>> _notifications = [
    {"title": "New Coffee Added!", "time": "2h ago"},
    {"title": "Your order is on the way", "time": "5h ago"},
    {"title": "Special discount for you", "time": "1d ago"},
  ];

  // Mock help/support messages
  List<Map<String, String>> _helpMessages = [
    {"question": "How to order coffee?", "answer": "Select a coffee from menu and add to cart."},
    {"question": "Payment options?", "answer": "We accept cash, card, and online payments."},
    {"question": "Delivery time?", "answer": "Usually 30-45 minutes within city limits."},
  ];

  @override
  void initState() {
    super.initState();
    _loadProfileImage();
  }

  Future<void> _loadProfileImage() async {
    final prefs = await SharedPreferences.getInstance();
    if (kIsWeb) {
      String? base64Image = prefs.getString('profile_image_web');
      if (base64Image != null) {
        setState(() {
          _webImage = base64Decode(base64Image);
        });
      }
    } else {
      String? path = prefs.getString('profile_image_mobile');
      if (path != null) {
        final file = File(path);
        if (await file.exists()) {
          setState(() {
            _profileImage = file;
          });
        }
      }
    }
  }

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (image != null) {
        final prefs = await SharedPreferences.getInstance();
        if (kIsWeb) {
          final bytes = await image.readAsBytes();
          setState(() {
            _webImage = bytes;
          });
          prefs.setString('profile_image_web', base64Encode(bytes));
        } else {
          final dir = await getApplicationDocumentsDirectory();
          final file = File('${dir.path}/profile_image.png');
          await File(image.path).copy(file.path);
          setState(() {
            _profileImage = file;
          });
          prefs.setString('profile_image_mobile', file.path);
        }
      }
    } catch (e) {
      print("Error picking image: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to pick image")),
      );
    }
  }

  void _editProfile() {
    final _nameController = TextEditingController(text: _name);
    final _emailController = TextEditingController(text: _email);
    final _contactController = TextEditingController(text: _contact);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Profile"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: _nameController, decoration: const InputDecoration(labelText: "Name")),
              TextField(controller: _emailController, decoration: const InputDecoration(labelText: "Email")),
              TextField(controller: _contactController, decoration: const InputDecoration(labelText: "Contact")),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _name = _nameController.text;
                  _email = _emailController.text;
                  _contact = _contactController.text;
                });
                Navigator.pop(context);
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  void _showOrders() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(title: const Text("My Orders"), backgroundColor: const Color(0xFF8C6542)),
          body: globalOrders.isEmpty
              ? const Center(child: Text("No orders yet"))
              : ListView.builder(
            itemCount: globalOrders.length,
            itemBuilder: (context, index) {
              final order = globalOrders[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  leading: const Icon(Icons.local_cafe, color: Colors.brown),
                  title: Text(order['name'] ?? ''),
                  subtitle: Text(
                      "Quantity: ${order['quantity']}  |  Date: ${order['date']}  |  Status: ${order['status']}"),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _showNotifications() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(title: const Text("Notifications"), backgroundColor: const Color(0xFF8C6542)),
          body: _notifications.isEmpty
              ? const Center(child: Text("No notifications"))
              : ListView.builder(
            itemCount: _notifications.length,
            itemBuilder: (context, index) {
              final notification = _notifications[index];
              return ListTile(
                leading: const Icon(Icons.notifications, color: Colors.brown),
                title: Text(notification['title']!),
                subtitle: Text(notification['time']!),
              );
            },
          ),
        ),
      ),
    );
  }

  void _showHelpSupport() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(title: const Text("Help & Support"), backgroundColor: const Color(0xFF8C6542)),
          body: _helpMessages.isEmpty
              ? const Center(child: Text("No help topics available"))
              : ListView.builder(
            itemCount: _helpMessages.length,
            itemBuilder: (context, index) {
              final item = _helpMessages[index];
              return ExpansionTile(
                leading: const Icon(Icons.help_outline, color: Colors.brown),
                title: Text(item['question']!),
                children: [Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Text(item['answer']!),
                )],
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5EDE0),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: const Text("My Profile", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
          child: Column(
            children: [
              // Profile image
              Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: const Color(0xFFD7B899),
                      child: ClipOval(
                        child: kIsWeb
                            ? (_webImage != null
                            ? Image.memory(_webImage!, width: 120, height: 120, fit: BoxFit.cover)
                            : Image.network(
                          'https://images.unsplash.com/photo-1669904914821-da10ce59d399?q=80&w=387&auto=format&fit=crop&ixlib=rb-4.1.0',
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                        ))
                            : (_profileImage != null
                            ? Image.file(_profileImage!, width: 120, height: 120, fit: BoxFit.cover)
                            : Image.network(
                          'https://images.unsplash.com/photo-1669904914821-da10ce59d399?q=80&w=387&auto=format&fit=crop&ixlib=rb-4.1.0',
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                        )),
                      ),
                    ),
                    GestureDetector(
                      onTap: _pickImage,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 18,
                        child: const Icon(Icons.photo_library, color: Colors.brown),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 15),
              Text(_name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.brown)),
              const SizedBox(height: 5),
              Text(_email, style: const TextStyle(color: Colors.grey, fontSize: 15)),
              const SizedBox(height: 5),
              Text(_contact, style: const TextStyle(color: Colors.grey, fontSize: 15)),
              const SizedBox(height: 25),

              ElevatedButton.icon(
                onPressed: _editProfile,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown[400],
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                  padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 12),
                ),
                icon: const Icon(Icons.edit, color: Colors.white),
                label: const Text("Edit Profile", style: TextStyle(color: Colors.white, fontSize: 16)),
              ),

              const SizedBox(height: 30),

              // Info Cards
              buildInfoCard(title: "Personal Info", subtitle: "Name, Email & Contact", icon: Icons.person, color: Colors.brown[300], onTap: _editProfile),
              buildInfoCard(title: "My Orders", subtitle: "View your past coffee orders", icon: Icons.local_cafe, color: Colors.brown[300], onTap: _showOrders),
              buildInfoCard(title: "Favorites", subtitle: "Your liked coffee items", icon: Icons.favorite, color: Colors.brown[300], onTap: () => Navigator.pushNamed(context, '/favorites')),
              buildInfoCard(title: "Notifications", subtitle: "App alerts and updates", icon: Icons.notifications, color: Colors.brown[300], onTap: _showNotifications),
              buildInfoCard(title: "Help & Support", subtitle: "Contact or FAQ", icon: Icons.help_outline, color: Colors.brown[300], onTap: _showHelpSupport),
              buildInfoCard(title: "Logout", subtitle: "Sign out from your account", icon: Icons.logout, color: Colors.red[300], isLogout: true, onTap: () async {
                final prefs = await SharedPreferences.getInstance();
                if (kIsWeb) {
                  prefs.remove('profile_image_web');
                } else {
                  prefs.remove('profile_image_mobile');
                  if (_profileImage != null && await _profileImage!.exists()) {
                    await _profileImage!.delete();
                  }
                }
                setState(() {
                  _webImage = null;
                  _profileImage = null;
                });
                Navigator.pushReplacementNamed(context, '/login');
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInfoCard({required String title, required String subtitle, required IconData icon, required Color? color, bool isLogout = false, VoidCallback? onTap}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 3,
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(backgroundColor: color, child: Icon(icon, color: Colors.white)),
        title: Text(title, style: TextStyle(color: isLogout ? Colors.red[600] : Colors.brown[700], fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }
}
