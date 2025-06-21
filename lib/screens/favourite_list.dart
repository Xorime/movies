import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/controllers/favourite_list_controller.dart';
import 'package:movies/controllers/root_controller.dart';
import 'package:movies/models/now_playing_movies_model.dart';
import 'package:movies/utils/button.dart';
import 'package:movies/utils/constants.dart';
import 'package:movies/utils/wgt.dart';
import 'package:movies/widgets/celll_movies.dart';

class FavouriteList extends StatelessWidget {
  final FavouriteListController _controller = Get.put(FavouriteListController());
  final RootController _rootController = Get.find<RootController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Wgt.appbar(title: 'Favourite List', centerTitle: false),
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return Obx(() {
      if (_rootController.isLoggedIn.value == false) {
        return _notLoggedIn();
      }

      if (_controller.favouriteList.isEmpty) {
        return _emptyState();
      }

      return Padding(
        padding: const EdgeInsets.only(bottom: 80),
        child: GridView.builder(
          padding: EdgeInsets.symmetric(vertical: kPadding8, horizontal: kPadding16),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: kPadding12,
            crossAxisSpacing: kPadding12,
            childAspectRatio: 0.65,
          ),
          itemCount: _controller.favouriteList.length,
          itemBuilder: (context, index) {
            NowPlayingMoviesModel model = _controller.favouriteList[index];

            return CelllMovies(model: model);
          },
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
          Spacer(flex: 3),
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
          Spacer(flex: 3),
        ],
      ),
    );
  }
}
