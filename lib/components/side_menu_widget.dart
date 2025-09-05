import 'package:bus_tracker/components/navigation_tile.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lucide_icons/lucide_icons.dart';

class SideMenuWidget extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;

  const SideMenuWidget({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 20.0,
        horizontal: 12,
      ), // Adjusted vertical padding
      child: Column(
        // Use Column as the top-level widget
        children: [
          // Optional: Add a logo or app name header
          // const Padding(
          //   padding: EdgeInsets.only(bottom: 30.0, top: 20.0),
          //   child: Text(
          //     'BUS TRACKER',
          //     style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          //   ),
          // ),
          Expanded(
            // <-- CRITICAL FIX: Wrap ListView with Expanded
            child: ListView(
              // shrinkWrap: true, // You might still need this if the ListView is inside another scrollable.
              // However, the Expanded takes precedence for height constraint.
              // primary: false, // If nested in another scrollable, set primary to false.
              children: [
                NavigationTile(
                  title: 'Map', // Added title
                  iconData: Iconsax.map_14,
                  onTap: () => onItemSelected(0),
                  isSelected: selectedIndex == 0, // Pass isSelected
                ),
                NavigationTile(
                  title: 'Buses', // Added title
                  iconData: Iconsax.bus,
                  onTap: () => onItemSelected(1),
                  isSelected: selectedIndex == 1, // Pass isSelected
                ),
                NavigationTile(
                  title: 'Settings', // Added title
                  iconData:
                      LucideIcons
                          .wrench, // Changed to shopping_cart as per previous code
                  onTap: () => onItemSelected(2),
                  isSelected: selectedIndex == 2, // Pass isSelected
                ),
                NavigationTile(
                  title: 'Analytics', // Added title
                  iconData: Iconsax.chart_square,
                  onTap: () => onItemSelected(3),
                  isSelected: selectedIndex == 3, // Pass isSelected
                ),
                NavigationTile(
                  title: 'Alerts', // Added title
                  iconData: Iconsax.warning_2,
                  onTap: () => onItemSelected(4),
                  isSelected: selectedIndex == 4, // Pass isSelected
                ),
                NavigationTile(
                  title: 'Profile', // Added title
                  iconData: LucideIcons.user,
                  onTap: () => onItemSelected(5),
                  isSelected: selectedIndex == 5, // Pass isSelected
                ),
                // Add more NavigationTiles as needed
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: Colors.blue,
              border: Border.all(
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
            child: Column(
              children: [
                Icon(
                  Iconsax.verify,
                  color: Theme.of(context).colorScheme.background,
                ),
                Text(
                  'Version 1.0',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.background,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          // Optional: Add a footer widget here, outside the Expanded ListView
          // const Padding(
          //   padding: EdgeInsets.only(top: 20.0),
          //   child: Text('Version 1.0'),
          // ),
        ],
      ),
    );
  }
}
