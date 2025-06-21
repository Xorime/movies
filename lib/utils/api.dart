import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movies/base/base_api.dart';
import 'package:movies/base/base_controllers.dart';

String baseUrl = dotenv.env['BASE_URL'] ?? 'google.com';

class Api extends BaseApi {
  final String _getPlayingNow = baseUrl + 'movie/now_playing';

  Future<void> getPlayingMovies({
    required BaseControllers controllers,
    required String language,
    required int page,
  }) =>
      apiFetch(
        url: _getPlayingNow + '?language=$language&page=$page',
        controller: controllers,
        debug: false,
      );
}
