// import 'package:bus_tracker/components/avatar_marker.dart';
// import 'package:bus_tracker/util/get_zoom.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:provider/provider.dart';

// class OpenStreetMap extends StatefulWidget {
//   const OpenStreetMap({super.key});

//   @override
//   State<OpenStreetMap> createState() => _OpenStreetMapState();
// }

// class _OpenStreetMapState extends State<OpenStreetMap> {
//   final MapController _mapController = MapController();
//   // default location value
//   LatLng driverLocation = LatLng(8.4240011, 7.5177209);
//   final LatLng? _phoneLocation = LatLng(6.4241890, 7.5178440);
//   bool _loading = true;

//   // firestore
//   FirebaseFirestore firestore = FirebaseFirestore.instance;
//   CollectionReference driverDetails = FirebaseFirestore.instance.collection(
//     'driverDetails',
//   );

//   Future<void> getOrderTracking() async {
//     try {
//       DocumentSnapshot snapshot =
//           await driverDetails.doc(driverDetails.id).get();
//       if (snapshot.exists) {
//         Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

//         // set new delvery driver loaction
//         setState(() {
//           driverLocation = LatLng(data["latitude"], data["longitude"]);
//           _loading = false;
//         });

//         // update camera
//         _mapController.move(driverLocation, 13.0);
//         // calculate remaining distance
//       } else {
//         print("Order ID: ${driverDetails.id}");

//         print("Document does not exist");
//       }
//     } catch (e) {
//       print("Error fetching location: $e");
//       setState(() => _loading = false);
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     getOrderTracking();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body:
//           _loading
//               ? const Center(child: CircularProgressIndicator())
//               : FlutterMap(
//                 mapController: _mapController,
//                 options: MapOptions(
//                   initialCenter: _phoneLocation ?? LatLng(0, 0),
//                   initialZoom: 13,
//                   onMapEvent: (event) {
//                     // push zoom updates to provider
//                     context.read<ZoomProvider>().setZoom(event.camera.zoom);
//                   },
//                 ),
//                 children: [
//                   TileLayer(
//                     urlTemplate:
//                         "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
//                     subdomains: const ['a', 'b', 'c'],
//                     userAgentPackageName: 'com.example.bustracker',
//                   ),
//                   if (_phoneLocation != null)
//                     MarkerLayer(
//                       markers: [
//                         Marker(
//                           point: _phoneLocation,
//                           width: 40,
//                           height: 40,
//                           child: const Icon(
//                             Icons.location_pin,
//                             color: Colors.red,
//                             size: 40,
//                           ),
//                         ),
//                         Marker(
//                           point: LatLng(6.4250, 7.5150),
//                           width: 80,
//                           height: 80,
//                           child: Column(
//                             children: [
//                               const Icon(
//                                 Icons.location_on,
//                                 color: Colors.green,
//                                 size: 40,
//                               ),
//                               Container(
//                                 color: Colors.white,
//                                 padding: const EdgeInsets.all(4),
//                                 child: const Text("Stop A"),
//                               ),
//                             ],
//                           ),
//                         ),

//                         Marker(
//                           point: driverLocation,
//                           width: 70,
//                           height: 90,
//                           child: AvatarMarker(
//                             imageUrl:
//                                 "https://i.pravatar.cc/150?img=3", // example avatar
//                           ),
//                         ),
//                       ],
//                     ),
//                 ],
//               ),
//     );
//   }
// }

import 'package:bus_tracker/components/avatar_marker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class OpenStreetMap extends StatefulWidget {
  const OpenStreetMap({super.key});

  @override
  State<OpenStreetMap> createState() => _OpenStreetMapState();
}

class _OpenStreetMapState extends State<OpenStreetMap> {
  final MapController _mapController = MapController();
  // Firestore instance
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    // Use a StreamBuilder to listen for real-time updates from Firestore.
    return StreamBuilder<QuerySnapshot>(
      stream: firestore.collection('driverDetails').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text('Something went wrong'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No drivers found.'));
        }

        // Dynamically create a list of markers for each driver.
        List<Marker> driverMarkers =
            snapshot.data!.docs.map((doc) {
              final data = doc.data() as Map<String, dynamic>;
              final LatLng driverLocation = LatLng(
                data["latitude"],
                data["longitude"],
              );
              final String driverId = data["driverId"] as String? ?? 'N/A';
              final String driverEmail = data["email"] as String? ?? 'N/A';
              final String tripId = data["tripId"] as String? ?? 'N/A';

              return Marker(
                point: driverLocation,
                width: 70,
                height: 90,
                child: AvatarMarker(
                  imageUrl: "https://i.pravatar.cc/150?u=$driverId",
                  // tooltip: "ID: $driverId\nEmail: $driverEmail\nTrip: $tripId",
                ),
              );
            }).toList();

        return Scaffold(
          body: FlutterMap(
            mapController: _mapController,
            options: const MapOptions(
              initialCenter: LatLng(6.4250, 7.5150),
              initialZoom: 13,
            ),
            children: [
              TileLayer(
                urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                userAgentPackageName: 'com.example.bustracker',
              ),
              MarkerLayer(markers: driverMarkers),
            ],
          ),
        );
      },
    );
  }
}
