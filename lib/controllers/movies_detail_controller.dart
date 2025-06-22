import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:movies/base/base_controllers.dart';
import 'package:movies/models/movie_detail_model.dart';
import 'package:movies/utils/utils.dart';

class MoviesDetailController extends BaseControllers {
  final int movieID;

  MoviesDetailController({required this.movieID});

  Rx<MovieDetailModel> model = MovieDetailModel().obs;
  final currencyFormatter = NumberFormat('#,##0', 'ID');

  @override
  void onInit() {
    super.onInit();
    load();
  }

  @override
  Future<void> load() async {
    super.load();
    setLoading(true);
    await api.getMoviesDetail(controllers: this, movieID: movieID);
  }

  @override
  void loadSuccess({required int requestCode, required response, required int statusCode}) {
    super.loadSuccess(requestCode: requestCode, response: response, statusCode: statusCode);
    setLoading(false);
    _parseData(response);
  }

  @override
  void loadFailed({required int requestCode, required Response response}) {
    super.loadFailed(requestCode: requestCode, response: response);
    setLoading(false);
    Utils.popUpFailed(body: 'Something went wrong. Please try again!');
  }

  void _parseData(Map json) {
    model.value = MovieDetailModel.fromJson(json);
  }

  String getProductionContries() {
    List<String> temp = [];

    for (ProductionCountries countries in model.value.productionCountries ?? []) {
      temp.add(countries.name ?? '-');
    }

    return temp.join(', ');
  }

  List<String> getGenres() {
    List<String> temp = [];

    for (Genres genres in model.value.genres ?? []) {
      temp.add(genres.name ?? '');
    }

    return temp;
  }

  String currencyFormatters({required String data}) {
    String stringNumber = '0';

    if (data != '-' || data != '0') {
      stringNumber = 'USD ' + currencyFormatter.format(double.parse(data));
    }

    return stringNumber;
  }
}
