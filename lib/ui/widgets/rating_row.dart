import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../util/index.dart';

class RatingRow extends StatefulWidget {
  const RatingRow({
    Key? key,
    required this.rating,
    required this.movieId,
    required this.isMovie,
  }) : super(key: key);

  final double rating;
  final int movieId;
  final bool isMovie;

  @override
  _RatingRowState createState() => _RatingRowState();
}

class _RatingRowState extends State<RatingRow> {
  bool isRated = false;
  double rate = 0.5;

  late ThemeData theme;
  late TextTheme textTheme;
  late TextStyle ratingCaptionStyle;
  late Color color;

  List<Widget> getStars() {
    final List<Widget> stars = <Widget>[];
    for (int i = 1; i <= 5; i++) {
      color = !isRated
          ? i * 2 <= widget.rating
              ? theme.accentColor
              : Colors.black12
          : i * 2 <= rate
              ? Colors.orange
              : Colors.black12;
      final GestureDetector star = GestureDetector(
        onTap: () {
          setState(() {
            isRated = true;
            rate = (i * 2).toDouble();
          });
        },
        child: Icon(
          Icons.star,
          color: color,
        ),
      );
      stars.add(star);
    }
    return stars;
  }

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    textTheme = theme.textTheme;
    ratingCaptionStyle = textTheme.caption!.copyWith(color: Colors.black45);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              widget.rating.toString(),
              style: textTheme.headline6!.copyWith(
                fontWeight: FontWeight.w400,
                color: theme.accentColor,
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              "details.widget.rating".tr,
              style: ratingCaptionStyle,
            ),
          ],
        ),
        const SizedBox(width: 16.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Row(
                  children: getStars(),
                ),
                if (isRated)
                  SizedBox(
                    height: 30,
                    width: 50,
                    child: TextButton(
                      style: ButtonStyle(backgroundColor: MaterialStateColor.resolveWith((Set<MaterialState> states) => darkAccentColor)),
                      onPressed: () {
                        //widget.isMovie ? MoviesService.rateMovie(widget.movieId, rate) : TvSeriesService.rateTv(widget.movieId, rate);
                      },
                      child: Text(
                        "details.grade".tr,
                        style: const TextStyle(color: Colors.white, fontSize: 12),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                else
                  const SizedBox(),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0, left: 4.0),
              child: Row(
                children: <Widget>[
                  Text(
                    "details.grade".tr,
                    style: ratingCaptionStyle,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
