import 'package:flutter/material.dart';
import '/flavor_config.dart';
import '/main_common.dart';

void main() {
  // Inject our own configurations
  // Crunchy Munchy

  mainCommon(
    FlavorConfig()
      ..appTitle = "Munchy Crunchy"
      ..imageLocation = "assets/images/munchy_crunchy.jpg"
      ..apiEndpoint = {
        Endpoints.items: "api.munchycrunchy.dev/items",
        Endpoints.details: "api.munchycrunchy.dev/items"
      }
      ..theme = ThemeData.dark(),
  );
}