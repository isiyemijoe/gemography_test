import 'package:flutter/material.dart';
import 'package:gemography_test/presentation/utils/constants.dart';
import 'package:gemography_test/presentation/utils/uihelper.dart';
import 'package:gemography_test/presentation/views/homepage.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  static String routeName = "/splash_screen";
  SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "$IMAGE_ASSET_PATH/gem.jpg",
              height: 70,
              width: 70,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Gemography",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(fontWeight: FontWeight.w100, fontSize: 25),
            )
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void load() async {
    await Future.delayed(Duration(seconds: 3));
    Get.offAllNamed(HomePage.routeName);
  }
}
