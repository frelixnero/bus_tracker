import 'package:flutter/material.dart';

class MyIconBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const MyIconBtn({Key? key, required this.icon, required this.onPressed})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Theme.of(context).colorScheme.primary,
      ),
      child: IconButton(icon: Icon(icon), onPressed: onPressed),
    );
  }
}
