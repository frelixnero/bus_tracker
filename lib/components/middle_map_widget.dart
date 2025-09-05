import 'package:bus_tracker/components/my_text_button.dart';
import 'package:bus_tracker/components/text_field.dart';
import 'package:bus_tracker/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';

class MiddleMapWidget extends StatelessWidget {
  MiddleMapWidget({Key? key}) : super(key: key);
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Determine colors based on theme and selection state
    final themeProvider = Provider.of<ThemeProvider>(context);
    final bool isDarkMode = themeProvider.isDarkMode;

    return Container(
      margin: EdgeInsets.only(),
      decoration: BoxDecoration(
        color:
            isDarkMode
                ? Theme.of(context).colorScheme.background
                : Theme.of(context).colorScheme.primary,
        border: Border(
          top: BorderSide(
            color: Theme.of(context).colorScheme.secondary,
            width: 2,
          ),
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.secondary,
            width: 2,
          ),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(
                width: 300, // set any width you want
                child: MyTextField(
                  controller: _controller,
                  hintText: "Search...",
                ),
              ),
              MyTextButton(
                buttonText: "Filter",
                onTap: () {},
                icon: LucideIcons.sliders,
              ),
            ],
          ),
          MyTextButton(
            buttonText: "Map Settings",
            onTap: () {},
            icon: LucideIcons.map,
          ),
        ],
      ),
    );
  }
}
