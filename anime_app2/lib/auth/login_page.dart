import 'package:flutter/material.dart';
import '../core/app_session.dart';
import 'register_page.dart';
import '../pages/root_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final email = TextEditingController();
  final pass = TextEditingController();

  bool isLoading = false;
  String? errorMsg;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text("Login",
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(fontWeight: FontWeight.bold)),

                const SizedBox(height: 40),

                TextField(
                  controller: email,
                  decoration: const InputDecoration(labelText: "Email"),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: pass,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: "Password"),
                ),

                if (errorMsg != null) ...[
                  const SizedBox(height: 12),
                  Text(errorMsg!, style: const TextStyle(color: Colors.red)),
                ],

                const SizedBox(height: 24),

                ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : () async {
                    setState(() {
                      isLoading = true;
                      errorMsg = null;
                    });

                    final ok =
                    await AppSession.login(email.text, pass.text);

                    setState(() => isLoading = false);

                    if (ok) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const RootScreen()),
                      );
                    } else {
                      setState(() =>
                      errorMsg = "Email atau password salah.");
                    }
                  },
                  child: isLoading
                      ? const CircularProgressIndicator()
                      : const Text("Login"),
                ),

                const SizedBox(height: 12),

                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const RegisterPage()),
                    );
                  },
                  child: const Text("Belum punya akun? Register"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
