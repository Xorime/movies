import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:movies/base/base_controllers.dart';
import 'package:movies/controllers/root_controller.dart';
import 'package:movies/models/movies_model.dart';
import 'package:movies/utils/keys.dart';

class FavouriteListController extends BaseControllers {
  RxList<MoviesModel> favouriteList = RxList();

  @override
  void onInit() {
    super.onInit();
    parseData();
  }

  Future<void> parseData() async {
    setLoading(true);

    favouriteList.clear();
    List temp = await GetStorage().read(storageFavourite) ?? [];

    for (Map json in temp) {
      MoviesModel model = MoviesModel(
        id: json['id'],
        posterPath: json['poster_path'],
      );

      model.isFavourite.value = true;
      favouriteList.add(model);
    }

    setLoading(false);
  }

  void onTapLogin() {
    final RootController _rootController = Get.find<RootController>();
    _rootController.onTapLogin();
    parseData();
  }
}
