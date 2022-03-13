import 'package:flutter/material.dart';
import 'package:flutter_getx_the_moviedb/features/detail/controller/index.dart';
import 'package:get/get.dart';

class RatingRow extends GetView<RatingRowController> {
  const RatingRow({
    Key? key,
    required this.id,
    required this.rating,
    required this.isMovie,
  }) : super(key: key);

  final int id;
  final double rating;
  final bool isMovie;

  List<Widget> getStars() {
    final List<Widget> stars = <Widget>[];
    Color color;
    for (int i = 1; i <= 5; i++) {
      color = !controller.isRated.value
          ? i * 2 <= rating
              ? Colors.blue
              : Colors.black12
          : i * 2 <= controller.rate.value
              ? Colors.orange
              : Colors.black12;
      final GestureDetector star = GestureDetector(
        onTap: () async {
          controller.isRated.value = true;
          controller.rate.value = (i * 2).toDouble();
          if (isMovie) {
            final Response<dynamic> response = await controller.detailRepository.rateMovie(
              id,
              <String, dynamic>{
                "value": controller.rate.value,
              },
            );
            if (response.statusCode == 201) {
              controller.isRatedApi.value = true;
              Get.snackbar("Success", "You voted ${controller.rate.value} for this ${isMovie ? "movie" : "tv series"}");
            }
          } else {
            final Response<dynamic> response = await controller.detailRepository.rateTvSeries(
              id,
              <String, dynamic>{
                "value": controller.rate.value,
              },
            );
            if (response.statusCode == 201) {
              controller.isRatedApi.value = true;
              Get.snackbar("Success", "You voted ${controller.rate.value} for this ${isMovie ? "movie" : "tv series"}");
            }
          }
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
                  rating.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 5),
            Container(
              height: 38,
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Colors.black38,
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: Center(
                child: Text(
                  "details.widget.rating".tr,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: 10.0),
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
                  child: Obx(
                    () => Row(
                      children: getStars(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 38,
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color: Colors.black38,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Obx(
                    () => Text(
                      controller.isRatedApi.value ? "Vote: ${controller.rate.value}" : "details.grade".tr,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                      maxLines: 1,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
