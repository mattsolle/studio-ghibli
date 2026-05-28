import 'package:flutter/material.dart';

import 'package:studioghibli/app.dart';
import 'package:studioghibli/core/injectables.dart';

void main() {
  // GetIt setup
  configureDependencies();
  runApp(MyApp());
}
