import 'package:flutter/material.dart';

enum Endpoints { items, details }

class FlavorConfig {
  FlavorConfig();
  String? appTitle;
  Map<Endpoints, String>? apiEndpoint;
  String? imageLocation;
  ThemeData? theme;

}