import 'package:flutter/material.dart';
import '../core/app_session.dart';
import 'login_page.dart';
import '../pages/root_screen.dart';

class AuthGuard extends StatelessWidget {
  const AuthGuard({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AppSession.isLoggedIn(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final loggedIn = snapshot.data == true;

        return loggedIn ? const RootScreen() : const LoginPage();
      },
    );
  }
}
