import 'package:flutter/material.dart';
import '../../core/app_session.dart';
import '../../auth/login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String username = "";
  String email = "";

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  Future<void> loadUser() async {
    final data = await AppSession.getUser();
    setState(() {
      username = data["username"] ?? "";
      email = data["email"] ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("User Information",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),

            Text("Username: $username",
                style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),

            Text("Email: $email", style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),

            ElevatedButton.icon(
              onPressed: () async {
                await AppSession.logout();
                if (context.mounted) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginPage()),
                        (_) => false,
                  );
                }
              },
              icon: const Icon(Icons.logout),
              label: const Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }
}
