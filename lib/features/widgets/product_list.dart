import 'package:flutter/material.dart';
import 'package:flutter_getx_the_moviedb/features/widgets/index.dart';
import 'package:flutter_getx_the_moviedb/models/index.dart';
import 'package:flutter_getx_the_moviedb/network/index.dart';
import 'package:flutter_getx_the_moviedb/routes/index.dart';
import 'package:get/get.dart';

class ProductList extends StatelessWidget {
  const ProductList({
    Key? key,
    required this.productList,
    required this.isMovie,
  }) : super(key: key);

  final List<dynamic>? productList;
  final bool isMovie;

  Widget getProductCard({
    required bool isMovie,
    required List<Movie>? movieList,
    required List<TvSeries>? tvSeriesList,
    required int index,
    required double aspectRatio,
  }) {
    if (isMovie) {
      return ProductCard(
        image: movieList?[index].posterPath != null ? 'https://image.tmdb.org/t/p/w185${movieList?[index].posterPath}' : Url.appLogoUrl,
        title: movieList?[index].title ?? "",
        vote: movieList?[index].voteAverage ?? "",
        releaseDate: movieList?[index].releaseDate ?? "",
        overview: movieList?[index].overview ?? "",
        genre: movieList?[index].genres != null ? movieList![index].genres!.map(createGenreContainer).toList() : <Widget>[],
        aspectRatio: aspectRatio,
        onTap: () {
          Get.toNamed(
            AppRoutes.DETAIL,
            arguments: <String, dynamic>{
              'movie': movieList?[index],
              'isMovie': true,
            },
          );
        },
      );
    } else {
      return ProductCard(
        image: tvSeriesList?[index].posterPath != null ? 'https://image.tmdb.org/t/p/w185${tvSeriesList?[index].posterPath}' : Url.appLogoUrl,
        title: tvSeriesList?[index].name ?? "",
        vote: tvSeriesList?[index].voteAverage ?? "",
        releaseDate: tvSeriesList?[index].firstAirDate ?? "",
        overview: tvSeriesList?[index].overview ?? "",
        genre: tvSeriesList?[index].genres != null ? tvSeriesList![index].genres!.map(createGenreContainer).toList() : <Widget>[],
        aspectRatio: aspectRatio,
        onTap: () {
          Get.toNamed(
            AppRoutes.DETAIL,
            arguments: <String, dynamic>{
              'tvSeries': tvSeriesList?[index],
              'isMovie': false,
            },
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Movie>? _movieList = isMovie ? productList as List<Movie>? : <Movie>[];
    final List<TvSeries>? _tvSeriesList = !isMovie ? productList as List<TvSeries>? : <TvSeries>[];
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints boxConstraints) {
        if (boxConstraints.maxWidth >= 1700) {
          const double _aspectRatio = 2;
          return GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              crossAxisSpacing: 0,
              childAspectRatio: _aspectRatio,
            ),
            itemCount: (isMovie ? _movieList : _tvSeriesList)?.length ?? 0,
            cacheExtent: (Get.context?.width ?? Get.width) / _aspectRatio,
            itemBuilder: (BuildContext context, int index) {
              return getProductCard(
                isMovie: isMovie,
                movieList: _movieList,
                tvSeriesList: _tvSeriesList,
                index: index,
                aspectRatio: _aspectRatio,
              );
            },
          );
        } else if (boxConstraints.maxWidth >= 1300) {
          const double _aspectRatio = 1.75;
          return GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 0,
              childAspectRatio: _aspectRatio,
            ),
            itemCount: (isMovie ? _movieList : _tvSeriesList)?.length ?? 0,
            cacheExtent: (Get.context?.width ?? Get.width) / _aspectRatio,
            itemBuilder: (BuildContext context, int index) {
              return getProductCard(
                isMovie: isMovie,
                movieList: _movieList,
                tvSeriesList: _tvSeriesList,
                index: index,
                aspectRatio: _aspectRatio,
              );
            },
          );
        } else if (boxConstraints.maxWidth >= 1000) {
          const double _aspectRatio = 1.75;
          return GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 0,
              childAspectRatio: _aspectRatio,
            ),
            itemCount: (isMovie ? _movieList : _tvSeriesList)?.length ?? 0,
            cacheExtent: (Get.context?.width ?? Get.width) / _aspectRatio,
            itemBuilder: (BuildContext context, int index) {
              return getProductCard(
                isMovie: isMovie,
                movieList: _movieList,
                tvSeriesList: _tvSeriesList,
                index: index,
                aspectRatio: _aspectRatio,
              );
            },
          );
        } else if (boxConstraints.maxWidth >= 600) {
          const double _aspectRatio = 1.75;
          return GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 0,
              childAspectRatio: _aspectRatio,
            ),
            itemCount: (isMovie ? _movieList : _tvSeriesList)?.length ?? 0,
            cacheExtent: (Get.context?.width ?? Get.width) / _aspectRatio,
            itemBuilder: (BuildContext context, int index) {
              return getProductCard(
                isMovie: isMovie,
                movieList: _movieList,
                tvSeriesList: _tvSeriesList,
                index: index,
                aspectRatio: _aspectRatio,
              );
            },
          );
        } else if (boxConstraints.maxWidth <= 280) {
          const double _aspectRatio = 2;
          return GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              crossAxisSpacing: 10,
              childAspectRatio: _aspectRatio,
            ),
            itemCount: (isMovie ? _movieList : _tvSeriesList)?.length ?? 0,
            cacheExtent: (Get.context?.width ?? Get.width) / _aspectRatio,
            itemBuilder: (BuildContext context, int index) {
              return ProductCardSmall(
                image: isMovie
                    ? (_movieList?[index].posterPath != null)
                        ? 'https://image.tmdb.org/t/p/w185${_movieList?[index].posterPath}'
                        : Url.appLogoUrl
                    : (_tvSeriesList?[index].posterPath != null)
                        ? 'https://image.tmdb.org/t/p/w185${_tvSeriesList?[index].posterPath}'
                        : Url.appLogoUrl,
                title: isMovie ? (_movieList?[index].title ?? "") : (_tvSeriesList?[index].name ?? ""),
                maxWidth: boxConstraints.maxWidth,
                aspectRatio: _aspectRatio,
                onTap: () {
                  if (isMovie) {
                    Get.toNamed(
                      AppRoutes.DETAIL,
                      arguments: <String, dynamic>{
                        'movie': _movieList?[index],
                        'isMovie': true,
                      },
                    );
                  } else {
                    Get.toNamed(
                      AppRoutes.DETAIL,
                      arguments: <String, dynamic>{
                        'tvSeries': _tvSeriesList?[index],
                        'isMovie': false,
                      },
                    );
                  }
                },
              );
            },
          );
        } else {
          const double _aspectRatio = 2.1;
          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            primary: false,
            itemCount: (isMovie ? _movieList : _tvSeriesList)?.length ?? 0,
            itemExtent: (Get.context?.width ?? Get.width) / _aspectRatio,
            itemBuilder: (BuildContext context, int index) {
              return getProductCard(
                isMovie: isMovie,
                movieList: _movieList,
                tvSeriesList: _tvSeriesList,
                index: index,
                aspectRatio: _aspectRatio,
              );
            },
          );
        }
      },
    );
  }
}
