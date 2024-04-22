import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'list_items.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String googleClientId = Platform.isAndroid
        ? '27211140087-9fpsjmoagvc3o2gbh25112v302vnhgts.apps.googleusercontent.com'
        : '27211140087-4ojqsrk3nivfu4d8oevjqnuldl586gat.apps.googleusercontent.com';
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData) {
          return const MyHomePage();
        }
        try {
          return SignInScreen(

            providers: [
              EmailAuthProvider(),
            ],
            headerBuilder: (context, constraints, shrinkOffset) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.asset('assets/flutterfire_300x.png'),
                ),
              );
            },
            subtitleBuilder: (context, action) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: action == AuthAction.signIn
                    ? const Text(
                        'Welcome to Hyper Garage Sale, please sign in!')
                    : const Text(
                        'Welcome to Hyper Garage Sale, please sign up!'),
              );
            },
          );
        } catch (e, s) {
          print("Exception: $e");
          print("Stacktrace: $s");
          return Center(
            child: Text("Error: ${e.toString()}"),
          );
        }
      },
    );
  }
}
