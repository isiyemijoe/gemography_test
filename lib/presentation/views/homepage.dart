import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gemography_test/domain/controllers/repo_controller.dart';
import 'package:gemography_test/presentation/utils/uihelper.dart';
import 'package:gemography_test/presentation/widgets/repo_tile.dart';
import 'package:get/get.dart';
import 'package:swipe_refresh/swipe_refresh.dart';

class HomePage extends StatefulWidget {
  static String routeName = "/home_page";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> implements WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  RepoController controller = Get.put(RepoController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("Trending Repos"),
      ),
      body: Column(
        children: [
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: UIhelper.textField(context, TextEditingController(),
                  hint: "Search repo", prefix: Icon(Icons.search))),
          Expanded(
            child: GetX<RepoController>(
              init: RepoController(),
              builder: (controller) {
                if (controller.firstTimeLoad) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                // return SwipeRefresh.adaptive(
                //     onRefresh: () {},
                //     padding: const EdgeInsets.symmetric(vertical: 10),
                //     stateStream: controller.isLoading.stream,
                //     children: controller.repolist
                //         .map((e) => GitRepoTile(repo: e))
                //         .toList());

                return ListView.builder(
                  controller: controller.scrollController,
                    itemCount: controller.repolist.length,
                    itemBuilder: (context, index) {
                      return GitRepoTile(repo: controller.repolist[index]);
                    });
              },
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          controller.refereshList();
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home_filled,
              ),
              label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: "Settings"),
        ],
      ),
    );
  }

  @override
  void didChangeAccessibilityFeatures() {
    // TODO: implement didChangeAccessibilityFeatures
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    log("locale has been changes to ${state.toString()}");
    print("locale has been changes to ${state.toString()}");

    // TODO: implement didChangeAppLifecycleState
  }

  @override
  void didChangeLocales(List<Locale> locales) {
    // TODO: implement didChangeLocales
    log("locale has been changes to ${locales.toString()}");
  }

  @override
  void didChangeMetrics() {
    log("Metrics has been changes");
    // TODO: implement didChangeMetrics
  }

  @override
  void didChangePlatformBrightness() {
    print("Brightness has been changes");
    // TODO: implement didChangePlatformBrightness
  }

  @override
  void didChangeTextScaleFactor() {
    // TODO: implement didChangeTextScaleFactor
  }

  @override
  void didHaveMemoryPressure() {
    // TODO: implement didHaveMemoryPressure
  }

  @override
  Future<bool> didPopRoute() {
    log("Route has been poped");
    // TODO: implement didPopRoute
    throw UnimplementedError();
  }

  @override
  Future<bool> didPushRoute(String route) {
    print("Route has been pushed  to $route");
    // TODO: implement didPushRoute
    throw UnimplementedError();
  }

  @override
  Future<bool> didPushRouteInformation(RouteInformation routeInformation) {
    // TODO: implement didPushRouteInformation
    throw UnimplementedError();
  }
}
