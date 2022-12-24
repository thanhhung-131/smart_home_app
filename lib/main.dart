import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:smart_home/views/login_view.dart';
import 'package:smart_home/views/verify_email_view.dart';

import 'firebase_options.dart';
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
          '/login': (context) => const LoginView(),
          '/register/': (context) => const RegisterView(),
        }),
  );
}

class Homepage extends StatelessWidget {
  const Homepage({super.key});
  StepState() {
    // TODO: implement StepState
    throw UnimplementedError();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = FirebaseAuth.instance.currentUser;
            if (user != null) {
              if (user.emailVerified) {
                print('Email is verified');
              } else {
                return const VerifyEmailView();
              }
            } else {
              return const LoginView();
            }
            return const Text('Done');
          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}
