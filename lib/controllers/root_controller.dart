import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:movies/base/base_controllers.dart';
import 'package:movies/utils/constants.dart';
import 'package:movies/utils/keys.dart';

class RootController extends BaseControllers {
  RxBool isLoggedIn = false.obs;
  RxInt index = 0.obs;
  late TabController tabController;
  List<Widget> screens = [];

  @override
  void onInit() {
    super.onInit();
    checkForToken();
  }

  Future<void> checkForToken() async {
    String token = await GetStorage().read(storageToken) ?? '';

    if (token != '') {
      isLoggedIn.value = true;
    }
  }

  Future<void> onTapLogin() async {
    String? token = dotenv.env['ACCESS_TOKEN'];

    isLoggedIn.value = true;
    await GetStorage().write(storageToken, token);
  }

  Future<bool> handleBack() async {
    if (tabController.index != 0) {
      navigateToHome();
      return false;
    }
    if (tabController.index == 0) {
      exit(0);
    }
    return false;
  }

  void navigateToHome() {
    tabController.animateTo(kIndexHome);
    index.value = kIndexHome;
  }

  void navigateToFavourite() {
    tabController.animateTo(kIndexFavourite);
    index.value = kIndexFavourite;
  }

  void navigateTo(int target) {
    tabController.animateTo(target);
    index.value = target;
  }
}
