import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Overview extends StatefulWidget {
  const Overview({
    Key? key,
    required this.overview,
  }) : super(key: key);

  final String overview;

  @override
  _OverviewState createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {
  bool flag = true;
  late String visibleText, invisibleText;
  int subLength = 100;

  @override
  void initState() {
    if (widget.overview.length > subLength) {
      visibleText = widget.overview.substring(0, subLength);
      invisibleText = widget.overview.substring(subLength, widget.overview.length);
    } else {
      visibleText = widget.overview;
      invisibleText = "";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          widget.overview,
          style: textTheme.subtitle1!.copyWith(fontSize: 18.0),
        ),
        const SizedBox(height: 8.0),
        Text(
          flag ? "$visibleText..." : visibleText + invisibleText,
          style: textTheme.bodyText2!.copyWith(
            color: Colors.black45,
            fontSize: 16.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15),
          child: GestureDetector(
            onTap: () {
              setState(() {
                flag = !flag;
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  flag ? 'details.more'.tr : 'details.less'.tr,
                  style: textTheme.bodyText2!.copyWith(fontSize: 16.0, color: Get.isDarkMode ? Colors.orange : Colors.blue),
                ),
                Icon(
                  Icons.keyboard_arrow_down,
                  size: 18.0,
                  color: Get.isDarkMode ? Colors.orange : Colors.blue,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
