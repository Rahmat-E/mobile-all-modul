import 'package:flutter/material.dart';
import '../core/app_session.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final username = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text("Register",
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 40),

                TextField(
                  controller: username,
                  decoration: const InputDecoration(labelText: "Username"),
                ),
                const SizedBox(height: 12),

                TextField(
                  controller: email,
                  decoration: const InputDecoration(labelText: "Email"),
                ),
                const SizedBox(height: 12),

                TextField(
                  controller: password,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: "Password"),
                ),

                const SizedBox(height: 24),

                ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : () async {
                    setState(() => isLoading = true);

                    await AppSession.saveUser(
                        username.text, email.text, password.text);

                    setState(() => isLoading = false);

                    Navigator.pop(context);
                  },
                  child: isLoading
                      ? const CircularProgressIndicator()
                      : const Text("Register"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
