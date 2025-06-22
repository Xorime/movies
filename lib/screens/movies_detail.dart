import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/controllers/movies_detail_controller.dart';
import 'package:movies/utils/constants.dart';
import 'package:movies/utils/extensions.dart';
import 'package:movies/utils/img.dart';
import 'package:movies/utils/wgt.dart';

class MoviesDetail extends StatelessWidget {
  final int movieID;

  MoviesDetail({
    super.key,
    required this.movieID,
  }) : _controller = Get.put(MoviesDetailController(movieID: movieID));

  final MoviesDetailController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text(
          'About this movie',
          style: context.workSans(color: Colors.black),
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.chevron_left),
          color: Colors.black,
        ),
      ),
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return Obx(() {
      if (_controller.state.value == ControllerState.loading) {
        return _loadingState();
      }

      return Padding(
        padding: EdgeInsets.all(kPadding12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _title(context),
              SizedBox(height: kPadding24),
              _image(),
              SizedBox(height: kPadding24),
              _genres(context),
              SizedBox(height: kPadding24),
              _reviews(context),
              SizedBox(height: kPadding24),
              _info(context),
              SizedBox(height: kPadding24),
              _overview(context),
              SizedBox(height: kPadding24),
            ],
          ),
        ),
      );
    });
  }

  Widget _title(BuildContext context) {
    return Text(
      _controller.model.value.title ?? '-',
      textAlign: TextAlign.center,
      style: context.workSans(fontSize: 24),
    );
  }

  Widget _reviews(BuildContext context) {
    return Row(
      children: [
        _popularity(context),
        SizedBox(width: kPadding12),
        _votes(context),
      ],
    );
  }

  Widget _genres(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (String strings in _controller.getGenres()) ...[
          Container(
            padding: EdgeInsets.all(kPadding8),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.2),
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(kPadding20),
            ),
            child: Text(
              strings,
              textAlign: TextAlign.center,
              style: context.workSans(),
            ),
          ),
          SizedBox(width: kPadding8),
        ],
      ],
    );
  }

  Widget _popularity(BuildContext context) {
    return Expanded(
        child: Container(
      padding: EdgeInsets.symmetric(vertical: kPadding12, horizontal: kPadding24),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.2),
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(kPadding20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Popularity',
            style: context.workSans(fontSize: 21, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: kPadding8),
          Text(
            '${_controller.model.value.popularity}',
            style: context.workSans(fontSize: 21, fontWeight: FontWeight.w300),
          ),
          SizedBox(height: kPadding8),
        ],
      ),
    ));
  }

  Widget _votes(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: kPadding12, horizontal: kPadding24),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.2),
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(kPadding20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Vote Average',
              style: context.workSans(fontSize: 21, fontWeight: FontWeight.w500),
            ),
            Text(
              '${_controller.model.value.voteAverage}',
              style: context.workSans(fontSize: 21, fontWeight: FontWeight.w300),
            ),
            Text('From ${_controller.model.value.voteCount} Votes'),
          ],
        ),
      ),
    );
  }

  Widget _image() {
    return SizedBox(
      width: Get.width / 2,
      child: Img(url: 'https://image.tmdb.org/t/p/w500${_controller.model.value.posterPath}'),
    );
  }

  Widget _info(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: kPadding12, horizontal: kPadding24),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.2),
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(kPadding20),
      ),
      child: Column(
        children: [
          _infoRow(title: 'Title', content: _controller.model.value.title ?? '-'),
          _infoRow(title: 'Original Title', content: _controller.model.value.originalTitle ?? '-'),
          _infoRow(title: 'Production Country', content: _controller.getProductionContries()),
          _infoRow(
            title: 'Budget',
            content: _controller.currencyFormatters(data: '${_controller.model.value.budget ?? '0'}'),
          ),
          _infoRow(
            title: 'Revenue',
            content: _controller.currencyFormatters(data: '${_controller.model.value.revenue ?? '0'}'),
          ),
        ],
      ),
    );
  }

  Widget _infoRow({required String title, required String content}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: kPadding8),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              title + ':',
              style: Get.context!.workSans(fontSize: kPadding16, fontWeight: FontWeight.w800),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(content),
          ),
        ],
      ),
    );
  }

  Widget _overview(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Overview :'),
        SizedBox(height: kPadding12),
        Container(
          padding: EdgeInsets.symmetric(vertical: kPadding12, horizontal: kPadding24),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.2),
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(kPadding20),
          ),
          child: Text(_controller.model.value.overview ?? ''),
        ),
      ],
    );
  }

  Widget _loadingState() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Wgt.loaderBox(width: 150, height: 50),
          SizedBox(height: kPadding16),
          Wgt.loaderBox(width: 150, height: 200),
          SizedBox(height: kPadding16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Wgt.loaderBox(width: 150, height: 100),
              Wgt.loaderBox(width: 150, height: 100),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(kPadding12),
            child: Column(
              children: [
                Wgt.loaderBox(width: Get.width, height: Get.height / 4),
                SizedBox(height: kPadding12),
                Wgt.loaderBox(width: Get.width, height: Get.height / 4),
              ],
            ),
          )
        ],
      ),
    );
  }
}
