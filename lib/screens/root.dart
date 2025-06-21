import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/controllers/root_controller.dart';
import 'package:movies/screens/favourite_list.dart';
import 'package:movies/screens/now_playing_movies.dart';
import 'package:movies/utils/constants.dart';
import 'package:movies/utils/extensions.dart';

class Root extends StatefulWidget {
  final String tag;

  Root({this.tag = ''});
  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> with TickerProviderStateMixin {
  RootController _controller = Get.put(RootController());

  @override
  void initState() {
    super.initState();
    _controller.screens = [
      NowPlayingMovies(),
      FavouriteList(),
    ];
    _controller.tabController = TabController(
      initialIndex: _controller.index.value,
      length: 2,
      vsync: this,
    );

    _controller.tabController.addListener(() => _handleTabSelection());
  }

  void _handleTabSelection() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (_controller.state.value == ControllerState.loading) {
        return IgnorePointer();
      }

      return PopScope(
        onPopInvokedWithResult: (didPop, result) => _controller.handleBack(),
        canPop: false,
        child: Scaffold(
          extendBody: true,
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
              child: BottomAppBar(
                height: kSizeBottomBarHeight,
                elevation: 0.0,
                child: SafeArea(
                  bottom: false,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _tab(
                        name: 'Now Playing',
                        icon: Icons.home_outlined,
                        index: 0,
                        context: context,
                      ),
                      _tab(
                        name: 'Favourite',
                        icon: Icons.star_border,
                        index: 1,
                        context: context,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          body: Container(
            child: TabBarView(
              controller: _controller.tabController,
              children: _controller.screens,
              physics: NeverScrollableScrollPhysics(),
            ),
          ),
        ),
      );
    });
  }

  Widget _tab({
    required String name,
    required IconData icon,
    required int index,
    required BuildContext context,
  }) {
    return Obx(
      () {
        if (_controller.state.value == ControllerState.loading) {
          return IgnorePointer();
        }

        return Expanded(
          child: InkWell(
            onTap: () => _controller.navigateTo(index),
            enableFeedback: false,
            splashColor: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(icon, color: _controller.index.value == index ? kColorWhite : kColorCoolGray),
                SizedBox(height: kPadding12),
                FittedBox(
                  child: Text(
                    name,
                    style: context.workSans(color: _controller.index.value == index ? kColorWhite : kColorCoolGray),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
