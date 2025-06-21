import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/controllers/now_playing_movies_controller.dart';
import 'package:movies/models/now_playing_movies_model.dart';
import 'package:movies/utils/constants.dart';
import 'package:movies/utils/img.dart';

class CelllMovies extends StatelessWidget {
  final NowPlayingMoviesModel model;

  CelllMovies({
    super.key,
    required this.model,
  });

  final NowPlayingMoviesController _mainController = Get.find<NowPlayingMoviesController>();

  @override
  Widget build(BuildContext context) {
    print(model.posterPath);
    return Stack(
      children: [
        Img(
          url: 'https://image.tmdb.org/t/p/w500${model.posterPath}',
        ),
        Positioned(
          child: _isAdult(context),
        ),
        Positioned(
          right: 1,
          child: _isFavourite(),
        ),
      ],
    );
  }

  Widget _isAdult(BuildContext context) {
    if (!model.adult) {
      return IgnorePointer();
    }

    return Container(
      padding: EdgeInsets.all(kPadding8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(kPadding12),
          bottomRight: Radius.circular(kPadding12),
        ),
        color: Colors.red[300],
      ),
      child: Text('PG 18+'),
    );
  }

  Widget _isFavourite() {
    return Obx(
      () => IconButton(
        onPressed: () => _mainController.onTapFavourite(model: model, isCurrentFavourite: model.isFavourite.value),
        icon: Icon(
          model.isFavourite.value ? Icons.star : Icons.star_border,
          color: model.isFavourite.value ? Colors.yellow : null,
        ),
      ),
    );
  }
}
