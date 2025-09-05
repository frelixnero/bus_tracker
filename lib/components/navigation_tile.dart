import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../themes/theme_provider.dart';

class NavigationTile extends StatelessWidget {
  final String title; // Added for text label
  final IconData iconData;
  final VoidCallback onTap; // Changed to VoidCallback for clarity
  final bool isSelected; // New parameter to indicate selection

  const NavigationTile({
    super.key,
    required this.title, // Required title
    required this.iconData,
    required this.onTap,
    this.isSelected = false, // Default to false
  });

  @override
  Widget build(BuildContext context) {
    // Determine colors based on theme and selection state
    final themeProvider = Provider.of<ThemeProvider>(context);
    final bool isDarkMode = themeProvider.isDarkMode;

    final Color backgroundColor =
        isSelected
            ? (isDarkMode
                ? Colors.orange.shade300
                : Colors.orange.shade300) // Neutral background
            : (isDarkMode
                ? Theme.of(context).colorScheme.background
                : Theme.of(
                  context,
                ).colorScheme.background); // Neutral background

    final Color iconTextColor =
        isSelected
            ? (isDarkMode
                ? Colors.white
                : Theme.of(
                  context,
                ).colorScheme.inversePrimary) // White icon/text for selected
            : (isDarkMode
                ? Colors.white70
                : Colors.black87); // Default icon/text

    return Padding(
      // Added Padding to create space between tiles
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
      ), // Spacing between tiles
      child: Material(
        // Use Material for elevation and inkwell effect
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          // Provides ripple effect on tap
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ), // Adjust padding as needed
            child: Row(
              children: [
                Icon(iconData, color: iconTextColor, size: 24),
                const SizedBox(width: 16), // Space between icon and text
                Text(
                  title,
                  style: TextStyle(
                    color: iconTextColor,
                    fontSize: 16,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
