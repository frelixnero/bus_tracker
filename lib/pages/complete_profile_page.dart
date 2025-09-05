import "package:bus_tracker/components/frosted_glass.dart";
import "package:bus_tracker/components/my_text_button.dart"; // Assuming you have these
import "package:bus_tracker/components/rotateing_box.dart";
import "package:bus_tracker/components/text_field.dart"; // Assuming you have these
import "package:bus_tracker/navigator%20key/navigation_service.dart";
import "package:bus_tracker/pages/home_page.dart";
import "package:bus_tracker/service/auth/auth_service.dart";
import "package:flutter/material.dart";
import "package:iconsax/iconsax.dart";

class CompleteProfilePage extends StatefulWidget {
  final String uid;
  const CompleteProfilePage({super.key, required this.uid});

  @override
  State<CompleteProfilePage> createState() => _CompleteProfilePageState();
}

class _CompleteProfilePageState extends State<CompleteProfilePage> {
  // text editing controllers
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  void completeRegistration(BuildContext context) async {
    final authService = AuthService();

    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: AnimBoxWidget(
            // Use your custom widget here
            redBoxHeight: 50.0,
            blueBoxHeight: 50.0,
            redBoxWidth: 50.0,
            blueBoxWidth: 50.0,
          ),
        );
      },
    );

    try {
      await authService.saveUserDetails(
        widget.uid,
        firstnameController.text,
        lastnameController.text,
        phoneController.text,
      );
      Navigator.of(context).pop();

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => HomePage()),
        (route) => false,
      );

      // Show success message
      ScaffoldMessenger.of(
        NavigationService.navigatorKey.currentState!.context,
      ).showSnackBar(
        const SnackBar(content: Text("Details saved successfully!")),
      );

      // Optionally navigate to a new screen or perform other actions
    } catch (e) {
      if (!mounted) return;
      Navigator.of(context).pop();

      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              title: const Text(
                "Error Creating Account",
                textAlign: TextAlign.center,
                style: TextStyle(color: Color.fromARGB(255, 107, 107, 107)),
              ),
              content: Text(e.toString(), textAlign: TextAlign.center),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("OK"),
                ),
              ],
            ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 5, 12),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 6,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(
                      255,
                      224,
                      239,
                      253,
                    ), // Background color for the left side
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      bottomLeft: Radius.circular(20.0),
                    ),
                    image: DecorationImage(
                      image: AssetImage("assets/images/reg_page1.png"),
                      fit: BoxFit.contain, // Use contain to show the full image
                      opacity: 1,
                    ),
                  ),
                  child: const Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        "DevNero", // Your logo text
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(
                            255,
                            255,
                            114,
                            0,
                          ), // Adjust color as needed
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // Right Section with Frosted Glass and Form
              Expanded(
                flex: 5,
                child: FrostedGlass(
                  // FrostedGlass now fills its parent Expanded
                  width: double.infinity, // It should take available width
                  height: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(
                      20.0,
                    ), // Padding inside the frosted glass
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Center(
                            child: AnimBoxWidget(
                              // Use your custom widget here
                              redBoxHeight: 50.0,
                              blueBoxHeight: 50.0,
                              redBoxWidth: 50.0,
                              blueBoxWidth: 50.0,
                            ),
                          ),
                        ),
                        const Text(
                          "Almost Done! ",
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white, // Adjust color as needed
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          "Getting to know you better.",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white70, // Adjust color as needed
                          ),
                        ),
                        const SizedBox(height: 30),
                        // Email Text Field
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: MyTextField(
                                controller: firstnameController,
                                hintText: "First Name",
                                obscureText: false,
                              ),
                            ),
                            Expanded(
                              child: MyTextField(
                                controller: lastnameController,
                                hintText: "Last Name",
                                obscureText: false,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        // Phone number Text Field
                        MyTextField(
                          controller: phoneController,
                          hintText: "Phone Number",
                          obscureText: false,
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  value: false, // Implement state for this
                                  onChanged: (value) {},
                                  activeColor: const Color.fromARGB(
                                    255,
                                    255,
                                    114,
                                    0,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        // Login Button
                        MyTextButton(
                          onTap: () => completeRegistration(context),
                          buttonText: "Finish",
                          icon: Iconsax.login,
                        ),
                        const SizedBox(height: 10),

                        const Text(
                          "By continuing, you agree to our Terms of Service and Privacy Policy.",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
