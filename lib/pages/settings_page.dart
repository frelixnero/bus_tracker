import 'package:bus_tracker/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings Page')),
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Settings will be displayed here'),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Logic to toggle theme can be added here
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            },
            child: Text('Toggle Theme'),
          ),
        ],
      ),
    );
  }
}
