import 'package:flutter/material.dart';
import 'package:gemography_test/presentation/routes.dart';
import 'package:get/route_manager.dart';

import 'presentation/utils/theme.dart';
import 'presentation/views/homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      getPages: AppRouter.getPages,
      initialRoute: AppRouter.initialRoute,
      theme: gemTheme,
    );
  }
}
