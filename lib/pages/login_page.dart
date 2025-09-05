import "package:bus_tracker/components/frosted_glass.dart";
import "package:bus_tracker/components/my_text_button.dart"; // Assuming you have these
import "package:bus_tracker/components/rotateing_box.dart";
import "package:bus_tracker/components/text_field.dart"; // Assuming you have these
import "package:bus_tracker/navigator%20key/navigation_service.dart";
import "package:bus_tracker/service/auth/auth_service.dart";
import "package:flutter/material.dart";
import "package:iconsax/iconsax.dart";

class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text editing controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmpwordController = TextEditingController();

  void login(BuildContext context) async {
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
      await authService.signInWithEmailAndPassword(
        emailController.text,
        passwordController.text,
      );
      NavigationService.navigatorKey.currentState!.pop();

      // Show success message
      ScaffoldMessenger.of(
        NavigationService.navigatorKey.currentState!.context,
      ).showSnackBar(const SnackBar(content: Text("Login successful!")));

      // Optionally navigate to a new screen or perform other actions
    } catch (e) {
      if (!mounted) return;
      NavigationService.navigatorKey.currentState!.pop();

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
                          "Welcome back! ",
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white, // Adjust color as needed
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          "I'm a professional",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white70, // Adjust color as needed
                          ),
                        ),
                        const SizedBox(height: 30),
                        // Email Text Field
                        MyTextField(
                          controller: emailController,
                          hintText: "Email address",
                          obscureText: false,
                        ),
                        const SizedBox(height: 15),
                        // Password Text Field
                        MyTextField(
                          controller: passwordController,
                          hintText: "Password",
                          obscureText: true,
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
                                const Text(
                                  "Keep me logged in",
                                  style: TextStyle(color: Colors.white70),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        // Login Button
                        MyTextButton(
                          onTap: () => login(context),
                          buttonText: "Log in",
                          icon: Iconsax.login,
                        ),
                        const SizedBox(height: 10),
                        // Forgot Password
                        Align(
                          alignment: Alignment.center,
                          child: GestureDetector(
                            onTap: () {
                              // Handle forgot password tap
                            },
                            child: const Text(
                              "Forgot password?",
                              style: TextStyle(color: Colors.white70),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Not a member ?"),
                            GestureDetector(
                              onTap: widget.onTap,
                              child: Text(
                                " Register now",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
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
