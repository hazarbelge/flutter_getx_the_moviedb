import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/index.dart';
import '../../util/index.dart';

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
        onTap: () {
          controller.isRated.value = true;
          controller.rate.value = (i * 2).toDouble();
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
                  width: 85,
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
                Obx(
                  () {
                    if (controller.isRated.value) {
                      return SizedBox(
                        height: 25,
                        width: 60,
                        child: TextButton(
                          style: ButtonStyle(backgroundColor: MaterialStateColor.resolveWith((Set<MaterialState> states) => darkAccentColor)),
                          onPressed: () async {
                            if (isMovie) {
                              final Response<dynamic> response = await controller.detailRepository.rateMovie(
                                id,
                                <String, dynamic>{
                                  "value": controller.rate.value,
                                },
                              );
                              if (response.statusCode == 201) {
                                controller.isRatedApi.value = true;
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
                              }
                            }
                          },
                          child: Text(
                            controller.isRatedApi.value ? "Vote Again" : "details.grade".tr,
                            style: const TextStyle(color: Colors.white, fontSize: 11),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
