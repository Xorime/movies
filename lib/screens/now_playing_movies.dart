import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/controllers/now_playing_movies_controller.dart';
import 'package:movies/controllers/root_controller.dart';
import 'package:movies/models/movies_model.dart';
import 'package:movies/utils/button.dart';
import 'package:movies/utils/constants.dart';
import 'package:movies/utils/input.dart';
import 'package:movies/utils/wgt.dart';
import 'package:movies/widgets/celll_movies.dart';

class NowPlayingMovies extends StatelessWidget {
  final NowPlayingMoviesController _controller = Get.put(NowPlayingMoviesController());
  final RootController _rootController = Get.find<RootController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Wgt.appbar(title: 'Now Playing', centerTitle: false),
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return Obx(() {
      if (_controller.state.value == ControllerState.loading) {
        return _loadingState();
      }

      if (_rootController.isLoggedIn.value == false) {
        return _notLoggedIn();
      }

      return RefreshIndicator(
        onRefresh: () => _controller.onRefresh(),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 80),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: kPadding16),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.2),
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(kPadding20),
                ),
                child: Input(
                  inputBorder: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: kPadding12),
                  controller: _controller.controllerSearch,
                  hint: 'Search for your movie',
                  hintStyle: Colors.black.withValues(alpha: 0.5),
                  onChangeText: (val) => _controller.searchMovie(val),
                ),
              ),
              if (_controller.arrDataFiltered.isEmpty) ...[
                _emptyState(),
              ],
              if (_controller.arrDataFiltered.isNotEmpty) ...[
                Expanded(
                  child: GridView.builder(
                    controller: _controller.scrollController,
                    padding: EdgeInsets.symmetric(vertical: kPadding8, horizontal: kPadding16),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: kPadding12,
                      crossAxisSpacing: kPadding12,
                      childAspectRatio: 0.65,
                    ),
                    itemCount: _controller.arrDataFiltered.length,
                    itemBuilder: (context, index) {
                      MoviesModel model = _controller.arrDataFiltered[index];

                      return CelllMovies(model: model);
                    },
                  ),
                ),
              ],
            ],
          ),
        ),
      );
    });
  }

  Widget _notLoggedIn() {
    return Center(
      child: Column(
        children: [
          Spacer(flex: 2),
          Text('You are not logged in!'),
          SizedBox(height: kPadding8),
          Button(
            text: 'Login',
            handler: () => _controller.onTapLogin(),
          ),
          Spacer(
            flex: 3,
          ),
        ],
      ),
    );
  }

  Widget _emptyState() {
    return Center(
      child: Column(
        children: [
          Spacer(flex: 2),
          Text('No Data Available'),
          Spacer(
            flex: 3,
          ),
        ],
      ),
    );
  }

  Widget _loadingState() {
    return GridView.builder(
      padding: EdgeInsets.symmetric(vertical: kPadding8, horizontal: kPadding16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: kPadding12,
        crossAxisSpacing: kPadding12,
        childAspectRatio: 3 / 4,
      ),
      itemBuilder: (context, index) {
        return Wgt.loaderBox();
      },
    );
  }
}
