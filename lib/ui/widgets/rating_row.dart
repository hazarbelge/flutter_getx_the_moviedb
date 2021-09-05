import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../util/index.dart';

class RatingRow extends StatefulWidget {
  const RatingRow({
    Key? key,
    required this.id,
    required this.rating,
    required this.isMovie,
  }) : super(key: key);

  final int id;
  final double rating;
  final bool isMovie;

  @override
  _RatingRowState createState() => _RatingRowState();
}

class _RatingRowState extends State<RatingRow> {
  bool isRated = false;
  double rate = 0.5;

  late Color color;

  List<Widget> getStars() {
    final List<Widget> stars = <Widget>[];
    for (int i = 1; i <= 5; i++) {
      color = !isRated
          ? i * 2 <= widget.rating
              ? Colors.blue
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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              height: 40,
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Colors.black38,
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: Center(
                child: Text(
                  widget.rating.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 5),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Colors.black38,
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: Text(
                "details.widget.rating".tr,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
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
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color: Colors.black38,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Row(
                    children: getStars(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color: Colors.black38,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Text(
                    "details.grade".tr,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                if (isRated)
                  SizedBox(
                    height: 25,
                    width: 60,
                    child: TextButton(
                      style: ButtonStyle(backgroundColor: MaterialStateColor.resolveWith((Set<MaterialState> states) => darkAccentColor)),
                      onPressed: () {
                        //widget.isMovie ? MoviesService.rateMovie(widget.movieId, rate) : TvSeriesService.rateTv(widget.movieId, rate);
                      },
                      child: Text(
                        "details.grade".tr,
                        style: const TextStyle(color: Colors.white, fontSize: 11),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                else
                  const SizedBox(),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
