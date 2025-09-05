import 'package:bus_tracker/pages/complete_profile_page.dart';
import 'package:bus_tracker/pages/home_page.dart';
import 'package:bus_tracker/service/auth/auth_service.dart';
import 'package:bus_tracker/service/auth/login_register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Show a loading indicator while the stream is loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final user = snapshot.data;

        if (user != null) {
          // A user is signed in. Now, check if their data exists in Firestore.
          return FutureBuilder<bool>(
            future: AuthService().hasUserData(user.uid),
            builder: (context, userSnapshot) {
              if (userSnapshot.connectionState == ConnectionState.waiting) {
                // Show a different loading indicator while checking data
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              }

              // Check if user data exists.
              if (userSnapshot.data == true) {
                // User is authenticated and their data exists, so navigate to the main app
                return HomePage();
              } else {
                // User is authenticated but their data is missing.
                // In your case, the data should now always be present after registration,
                // so we can directly go to the home page.
                return CompleteProfilePage(uid: user.uid);
              }
            },
          );
        } else {
          // No user is signed in, so show the login/register page
          return LoginOrRegisterPage();
        }
      },
    );
  }
}
