// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import 'package:bus_tracker/pages/map_page.dart';
// import 'package:bus_tracker/pages/settings_page.dart';
// import 'package:bus_tracker/themes/theme_provider.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   int navRailIndex = 0;

//   void _onNavSelect(int i) => setState(() => navRailIndex = i);

//   late final List<Widget> _pages = [
//     const MapPage(),
//     const SettingsPage(),
//     const Center(child: Text('Cart')),
//     const Center(child: Text('Profile')),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     final theme = context.watch<ThemeProvider>();

//     return Scaffold(
//       body: Row(
//         children: [
//           SizedBox(
//             width: 80,
//             child: Scrollbar(
//               thumbVisibility: true,
//               child: SingleChildScrollView(
//                 child: IntrinsicHeight(
//                   child: NavigationRail(
//                     groupAlignment: -1.0,
//                     selectedIndex: navRailIndex,
//                     onDestinationSelected: _onNavSelect,
//                     useIndicator: true,
//                     labelType: NavigationRailLabelType.all,
//                     backgroundColor:
//                         theme.themeData.colorScheme.secondaryContainer,
//                     leading: const Padding(
//                       padding: EdgeInsets.only(top: 12.0),
//                       child: Icon(Icons.directions_bus),
//                     ),
//                     destinations: const [
//                       NavigationRailDestination(
//                         icon: Icon(Icons.map_outlined),
//                         selectedIcon: Icon(Icons.map),
//                         label: Text('Map'),
//                       ),
//                       NavigationRailDestination(
//                         icon: Icon(Icons.settings_outlined),
//                         selectedIcon: Icon(Icons.settings),
//                         label: Text('Settings'),
//                       ),
//                       NavigationRailDestination(
//                         icon: Icon(Icons.shopping_cart_outlined),
//                         selectedIcon: Icon(Icons.shopping_cart),
//                         label: Text('Cart'),
//                       ),
//                       NavigationRailDestination(
//                         icon: Icon(Icons.person_outline),
//                         selectedIcon: Icon(Icons.person),
//                         label: Text('Profile'),
//                       ),
//                     ],
//                     trailing: Padding(
//                       padding: const EdgeInsets.only(top: 12.0),
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           IconButton(
//                             tooltip:
//                                 theme.isDarkMode
//                                     ? 'Switch to Light'
//                                     : 'Switch to Dark',
//                             icon: Icon(
//                               theme.isDarkMode
//                                   ? Icons.light_mode
//                                   : Icons.dark_mode,
//                             ),
//                             onPressed:
//                                 () =>
//                                     context.read<ThemeProvider>().toggleTheme(),
//                           ),
//                           const SizedBox(height: 8),
//                           IconButton(
//                             tooltip: 'Open Settings',
//                             icon: const Icon(Icons.tune),
//                             onPressed: () => _onNavSelect(1),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           const VerticalDivider(width: 1),
//           Expanded(child: _pages[navRailIndex]),
//         ],
//       ),
//     );
//   }
// }

// ignore_for_file: unused_field

import 'package:bus_tracker/components/side_menu_widget.dart';
import 'package:bus_tracker/components/test_app.dart';
import 'package:bus_tracker/pages/map_page.dart';
import 'package:bus_tracker/pages/profile_page.dart';
import 'package:bus_tracker/pages/settings_page.dart';
import 'package:bus_tracker/util/responsive.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  final List<Widget> _pages = [
    MapPage(),
    const SettingsPage(),
    const TestApp(),
    const Center(child: Text('Analytics')),
    const Center(child: Text('Notifications')),
    ProfilePage(),
  ];

  void _onMenuItemSelected(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    return Scaffold(
      drawer:
          !isDesktop
              ? SizedBox(
                width: 250,
                child: SideMenuWidget(
                  selectedIndex: selectedIndex,
                  onItemSelected: _onMenuItemSelected,
                ),
              )
              : null,
      body: SafeArea(
        child: Row(
          children: [
            if (isDesktop)
              Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                    color:
                        Theme.of(
                          context,
                        ).colorScheme.background, // background color
                    border: Border(
                      right: BorderSide(
                        color:
                            Theme.of(
                              context,
                            ).colorScheme.secondary, // border color
                        width: 2, // thickness of border
                      ),
                    ),
                  ),

                  child: Column(
                    children: [
                      Expanded(
                        child: SideMenuWidget(
                          selectedIndex: selectedIndex,
                          onItemSelected: _onMenuItemSelected,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            Expanded(flex: 10, child: _pages[selectedIndex]),
          ],
        ),
      ),
    );
  }
}
