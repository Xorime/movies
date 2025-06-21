import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/controllers/now_playing_movies_controller.dart';
import 'package:movies/controllers/root_controller.dart';
import 'package:movies/models/now_playing_movies_model.dart';
import 'package:movies/utils/button.dart';
import 'package:movies/utils/constants.dart';
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

      if (_controller.arrData.isEmpty) {
        return _emptyState();
      }

      return RefreshIndicator(
        onRefresh: () => _controller.onRefresh(),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 80),
          child: GridView.builder(
            controller: _controller.scrollController,
            padding: EdgeInsets.symmetric(vertical: kPadding8, horizontal: kPadding16),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: kPadding12,
              crossAxisSpacing: kPadding12,
              childAspectRatio: 0.65,
            ),
            itemCount: _controller.arrData.length,
            itemBuilder: (context, index) {
              NowPlayingMoviesModel model = _controller.arrData[index];

              return CelllMovies(model: model);
            },
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
