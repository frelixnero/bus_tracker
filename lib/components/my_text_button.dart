import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../themes/theme_provider.dart';

// class MyTextButton extends StatelessWidget {
//   final String buttonText;
//   final Function()? onTap;
//   final IconData? icon;
//   MyTextButton({
//     super.key,
//     required this.buttonText,
//     required this.onTap,
//     required this.icon,
//   });

//   @override
//   Widget build(BuildContext context) {
//     // Determine colors based on theme and selection state
//     final themeProvider = Provider.of<ThemeProvider>(context);
//     final bool isDarkMode = themeProvider.isDarkMode;

//     return Material(
//       color:
//           isDarkMode
//               ? Theme.of(context).colorScheme.primary
//               : Theme.of(context).colorScheme.background,
//       borderRadius: BorderRadius.circular(10),
//       child: InkWell(
//         borderRadius: BorderRadius.circular(10),
//         onTap: onTap,
//         hoverColor:
//             isDarkMode
//                 ? Theme.of(context).colorScheme.secondary
//                 : Theme.of(context).colorScheme.background, // hover color
//         child: Container(
//           height: 50,
//           decoration: BoxDecoration(
//             color:
//                 isDarkMode
//                     ? Theme.of(context).colorScheme.primary
//                     : Theme.of(context).colorScheme.background,
//             borderRadius: BorderRadius.circular(10),
//           ),
//           padding: EdgeInsets.only(left: 10, right: 10),
//           margin: EdgeInsets.symmetric(horizontal: 10),
//           child: Center(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Text(
//                   buttonText,

//                   style: TextStyle(
//                     fontWeight: FontWeight.w500,
//                     fontSize: 14,
//                     color: Theme.of(context).colorScheme.inversePrimary,
//                   ),
//                 ),
//                 SizedBox(width: 20),
//                 Icon(icon, color: Theme.of(context).colorScheme.inversePrimary),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class MyTextButton extends StatefulWidget {
  final String buttonText;
  final Function()? onTap;
  final IconData? icon;

  const MyTextButton({
    super.key,
    required this.buttonText,
    required this.onTap,
    required this.icon,
  });

  @override
  State<MyTextButton> createState() => _MyTextButtonState();
}

class _MyTextButtonState extends State<MyTextButton> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),

          height: 50,
          decoration: BoxDecoration(
            border: Border.all(
              color:
                  _isHovering
                      ? Theme.of(context).colorScheme.inversePrimary
                      : Colors.transparent,
            ),
            color:
                _isHovering
                    ? Theme.of(context).colorScheme.secondary.withOpacity(
                      0.3,
                    ) // hover color
                    : (isDarkMode
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.background),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.buttonText,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
              Icon(
                widget.icon,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
