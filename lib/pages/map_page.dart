import 'package:bus_tracker/components/header_widget.dart';
import 'package:bus_tracker/components/middle_map_widget.dart';
import 'package:bus_tracker/components/open_street_map.dart';
import 'package:flutter/material.dart';

class MapPage extends StatelessWidget {
  MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Column(
        children: [
          HeaderWidget(buildContext: context),
          MiddleMapWidget(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Container(
                color: Theme.of(context).colorScheme.background,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: OpenStreetMap(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
