import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:movies/base/base_controllers.dart';
import 'package:movies/controllers/favourite_list_controller.dart';
import 'package:movies/controllers/root_controller.dart';
import 'package:movies/models/now_playing_movies_model.dart';
import 'package:movies/utils/keys.dart';
import 'package:movies/utils/utils.dart';

class NowPlayingMoviesController extends BaseControllers {
  RxList<NowPlayingMoviesModel> arrData = RxList();
  int page = 1;

  ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    _setupScrollListener();
    load();
  }

  void _setupScrollListener() {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels == 0) {
          // You're at the top.
        } else {
          // You're at the bottom.
          loadMore();
        }
      }
    });
  }

  Future loadMore() async {
    await api.getPlayingMovies(controllers: this, language: 'en-US', page: page + 1);
  }

  Future<void> onRefresh() async {
    arrData.clear();
    page = 1;
    load();
  }

  @override
  void load() async {
    super.load();
    setLoading(true);
    await api.getPlayingMovies(controllers: this, language: 'en-US', page: page);
  }

  @override
  void loadSuccess({required int requestCode, required response, required int statusCode}) {
    super.loadSuccess(requestCode: requestCode, response: response, statusCode: statusCode);
    setLoading(false);
    _parseData(response['results'] ?? []);
    _parsePagination(currentPage: response['page'] ?? 1);
  }

  void _parseData(List data) async {
    List favouriteList = await GetStorage().read(storageFavourite) ?? [];

    for (Map json in data) {
      NowPlayingMoviesModel model = NowPlayingMoviesModel.fromJson(json);

      Map? temp = favouriteList.firstWhereOrNull((e) => e['id'] == model.id);

      if (temp != null) {
        model.isFavourite.value = true;
      }

      arrData.add(model);
    }
  }

  void _parsePagination({required int currentPage}) {
    page = currentPage;
  }

  void onTapLogin() {
    final RootController _rootController = Get.find<RootController>();
    _rootController.onTapLogin();
    load();
  }

  Future<void> onTapFavourite({required NowPlayingMoviesModel model, required bool isCurrentFavourite}) async {
    List favouriteList = await GetStorage().read(storageFavourite) ?? [];

    if (isCurrentFavourite) {
      model.isFavourite.value = false;
      favouriteList.removeWhere((e) => e['id'] == model.id);
      Utils.popUpSuccess(body: 'Removed from favourite list');
    } else {
      model.isFavourite.value = true;
      favouriteList.add({
        'id': model.id,
        'poster_path': model.posterPath,
      });
      Utils.popUpSuccess(body: 'Added to favourite list');
    }

    await GetStorage().write(storageFavourite, favouriteList);

    if (Get.isRegistered<FavouriteListController>()) {
      FavouriteListController _tempController = Get.find<FavouriteListController>();
      _tempController.parseData();
    }
  }
}
