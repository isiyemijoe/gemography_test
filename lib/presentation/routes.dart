import 'package:gemography_test/presentation/views/homepage.dart';
import 'package:gemography_test/presentation/views/splash_screen.dart';
import 'package:get/get.dart';

class AppRouter {
  static String initialRoute = SplashScreen.routeName;

  static List<GetPage> getPages = [
    GetPage(
        name: SplashScreen.routeName,
        page: () => SplashScreen(),
        transition: Transition.fadeIn),
    GetPage(
        name: HomePage.routeName,
        page: () => HomePage(),
        transition: Transition.rightToLeftWithFade),
  ];
}
