import 'package:flutter/material.dart';
import 'package:smart_home/constants/routes.dart';
import 'package:smart_home/services/auth/auth_service.dart';
import 'package:smart_home/views/login_view.dart';
import 'package:smart_home/views/smart_home_control_view.dart';
import 'package:smart_home/views/verify_email_view.dart';

import 'views/register_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Homepage(),
        routes: {
          loginRoute: (context) => const LoginView(),
          registerRoute: (context) => const RegisterView(),
          controllerRoute: (context) => const SmartHomeControls(),
          VerifyEmailRoute: (context) => const VerifyEmailView(),
        }),
  );
}

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthService.firebase().initialize(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = AuthService.firebase().currentUser;
            if (user != null) {
              if (user.isEmailVerified) {
                return const SmartHomeControls();
              } else {
                return const VerifyEmailView();
              }
            } else {
              return const LoginView();
            }
          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}

