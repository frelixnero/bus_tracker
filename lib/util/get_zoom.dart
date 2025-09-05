import 'package:flutter/material.dart';

class ZoomProvider extends ChangeNotifier {
  double _zoom = 14; // default zoom
  double get zoom => _zoom;

  void setZoom(double value) {
    _zoom = value;
    notifyListeners();
  }
}
