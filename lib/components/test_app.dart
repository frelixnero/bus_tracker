import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class TestApp extends StatelessWidget {
  const TestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: FutureBuilder<Position>(
              future: Geolocator.getCurrentPosition(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                } else {
                  final pos = snapshot.data!;
                  return Text("Lat: ${pos.latitude}, Lng: ${pos.longitude}");
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
