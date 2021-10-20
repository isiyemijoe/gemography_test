import 'package:flutter/material.dart';
import 'package:gemography_test/domain/models/git_repo.dart';
import 'package:gemography_test/domain/services/api_client.dart';
import 'package:get/get.dart';
import 'package:swipe_refresh/swipe_refresh.dart';

class RepoController extends GetxController {
  var _firstTime = true.obs;
  var pages = 1;
  var isLoading = SwipeRefreshState.loading.obs;
  TextEditingController searchController;
  var _repoList = <GitRepo>[].obs;
  ScrollController scrollController;

  @override
  void onInit() {
    searchController = TextEditingController();
    scrollController = ScrollController();
    listenToController();
    refereshList();
    super.onInit();
  }

  listenToController() {
    scrollController.addListener(() {
      double viewRatio = scrollController.position.pixels /
          scrollController.position.maxScrollExtent;
      print(viewRatio);
      if (viewRatio >= 0.70 && viewRatio <= 0.75) {
        print("Within range");
        if (isLoading.value != SwipeRefreshState.loading) {
          print("Refereshing");

          refereshList();
        }
      }
    });
  }

  List<GitRepo> get repolist => _repoList.value;
  bool get firstTimeLoad => _firstTime.value;

  set repolist(List<GitRepo> repolist) {
    _repoList.addAll(repolist);
  }

  set firstTimeLoad(bool state) {
    _firstTime.value = state;
  }

  Future<List<GitRepo>> refereshList() async {
    ApiClient apiClient = ApiClient(showError: true);

    try {
      isLoading.value = SwipeRefreshState.loading;
      var response = await apiClient.get(url: pages > 1 ? "&page=$pages" : "");
      List<GitRepo> result =
          response["items"].map<GitRepo>((e) => GitRepo.fromJson(e)).toList();
      print(result.length);
      repolist = result;
      pages += 1;
      firstTimeLoad = false;
      isLoading.value = SwipeRefreshState.hidden;

      return repolist;
    } catch (e) {
      print(e);
      firstTimeLoad = false;
      isLoading.value = SwipeRefreshState.hidden;

      return [];
    }
  }
}
