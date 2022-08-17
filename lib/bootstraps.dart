import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_portal/flutter_portal.dart';

void bootstraps(Widget app) async {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  runApp(Portal(child: app));
}