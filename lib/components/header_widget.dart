// lib/components/header_widget.dart (Corrected)
import 'package:bus_tracker/components/my_icon_btn.dart';
import 'package:bus_tracker/components/toggle_switch.dart';
import 'package:bus_tracker/themes/theme_provider.dart';
import 'package:bus_tracker/util/responsive.dart';
import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';

class HeaderWidget extends StatelessWidget {
  HeaderWidget({super.key, required this.buildContext});

  final BuildContext buildContext;
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                if (!isDesktop)
                  InkWell(
                    onTap: () => Scaffold.of(buildContext).openDrawer(),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.menu,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.only(left: 12, right: 8.0),
                  child: Text(
                    "Tracking",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).colorScheme.primary,
                    border: Border.all(
                      color: Theme.of(context).colorScheme.secondary,
                      width: 2,
                    ),
                  ),
                  height: 50,
                  width: 50,
                  child: DotLottieLoader.fromAsset(
                    "assets/lottie anim/map_4.lottie",
                    frameBuilder: (BuildContext ctx, DotLottie? dotlottie) {
                      if (dotlottie != null) {
                        return Lottie.memory(
                          dotlottie.animations.values.single,
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
              ],
            ),

            Row(
              children: [
                MyToggleSwitch(),
                VerticalDivider(color: Colors.black, thickness: 2, width: 2),
                MyIconBtn(icon: Iconsax.notification, onPressed: () {}),
                VerticalDivider(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  thickness: 2,
                ),
                MyIconBtn(icon: LucideIcons.messageSquare, onPressed: () {}),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
