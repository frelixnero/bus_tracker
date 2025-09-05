import 'package:bus_tracker/components/my_text_button.dart';
import 'package:bus_tracker/components/rotateing_box.dart';
import 'package:bus_tracker/service/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimBoxWidget(
              redBoxHeight: 52,
              blueBoxHeight: 52,
              redBoxWidth: 52,
              blueBoxWidth: 52,
            ),
            const SizedBox(height: 20),
            MyTextButton(
              buttonText: "Log Out",
              onTap: () {
                AuthService().signOut();
              },
              icon: Iconsax.logout,
            ),
          ],
        ),
      ),
    );
  }
}
