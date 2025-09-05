import 'package:bus_tracker/util/get_zoom.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AvatarMarker extends StatelessWidget {
  final String imageUrl;

  AvatarMarker({super.key, required this.imageUrl});

  double adjustForZoom(double size, BuildContext context) {
    final zoomProvider = Provider.of<ZoomProvider>(context);
    final _zoomLevel = zoomProvider.zoom;
    // Adjust size based on zoom level
    if (_zoomLevel < 10) {
      return size * 0.5; // smaller for low zoom
    } else if (_zoomLevel < 15) {
      return size; // normal size for mid zoom
    } else {
      return size * 1.2; // larger for high zoom
    }
  }

  @override
  Widget build(BuildContext context) {
    final zoomProvider = Provider.of<ZoomProvider>(context);
    final _zoomLevel = zoomProvider.zoom;
    print(zoomProvider.zoom);

    return SizedBox(
      width: adjustForZoom(70, context), // match Marker width
      height: adjustForZoom(90, context), // match Marker height
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Teardrop background
          ClipPath(
            clipper: TeardropClipper(),
            child: Container(
              width: adjustForZoom(60, context),
              height: adjustForZoom(80, context),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 255, 238, 1),
                    Color.fromARGB(255, 223, 30, 16),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),

          // Circular Avatar inside
          Positioned(
            top: 12,
            child: CircleAvatar(
              radius: adjustForZoom(22, context),
              backgroundImage: NetworkImage(imageUrl),
              backgroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class TeardropClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    // Circle top
    path.addOval(
      Rect.fromCircle(
        center: Offset(size.width / 2, size.width / 2),
        radius: size.width / 2,
      ),
    );

    // Triangle bottom
    path.moveTo(size.width / 2, size.height);
    path.lineTo(0, size.width / 2);
    path.lineTo(size.width, size.width / 2);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
