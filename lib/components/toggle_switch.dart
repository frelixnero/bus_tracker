import 'package:bus_tracker/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

class MyToggleSwitch extends StatefulWidget {
  MyToggleSwitch({super.key});
  @override
  State<MyToggleSwitch> createState() => _MyToggleSwitchState();
}

class _MyToggleSwitchState extends State<MyToggleSwitch> {
  @override
  Widget build(BuildContext context) {
    // 1. Listen to ThemeProvider: This causes the widget to rebuild when themeProvider.notifyListeners() is called.
    final themeProvider = Provider.of<ThemeProvider>(context);
    final bool isDarkMode = themeProvider.isDarkMode;

    // 2. Determine the current selected index for the MyToggleSwitch based on the theme state.
    // If it's DarkMode (isDarkMode is true), select index 0. Otherwise, select index 1.
    final int currentToggleIndex = isDarkMode ? 0 : 1;
    return Card(
      elevation: 3,
      shadowColor: isDarkMode ? Colors.grey.shade500 : Colors.grey,
      color: Colors.transparent,
      child: ToggleSwitch(
        minWidth: 90.0,
        // ✨ CRITICAL FIX: Set initialLabelIndex dynamically based on `isDarkMode`
        initialLabelIndex: currentToggleIndex,
        cornerRadius: 20.0,
        activeFgColor: Colors.white,
        inactiveBgColor: Colors.grey,
        inactiveFgColor: Colors.white,
        totalSwitches: 2,
        labels: const ['Dark', 'Light'], // Simplified labels for brevity
        // ✨ CRITICAL FIX: Ensure icons match labels logically (moon for Dark, sun for Light)
        icons: const [FontAwesomeIcons.moon, FontAwesomeIcons.sun],
        activeBgColors: const [
          [Colors.blueGrey, Colors.black], // Darker background for Dark mode
          [Colors.amber, Colors.orange], // Brighter background for Light mode
        ],
        onToggle: (index) {
          // Ensure index is not null (can happen with some older versions or specific interactions)
          if (index != null) {
            // Only toggle theme if the selected index is DIFFERENT from the current theme mode
            // This prevents unnecessary toggles if the user taps the currently active mode
            final int desiredModeIndex = index;
            final int currentModeIndex = isDarkMode ? 0 : 1;

            if (desiredModeIndex != currentModeIndex) {
              themeProvider.toggleTheme();
            }
            print('Switched to index: $index');
          }
        },
      ),
    );
  }
}
