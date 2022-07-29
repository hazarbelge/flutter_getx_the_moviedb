import 'package:flutter/material.dart';
import 'package:flutter_getx_the_moviedb/core/utils/index.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAppBar extends PreferredSize {
  const CustomAppBar({
    Key? key,
    this.height = 70,
  }) : super(key: key, preferredSize: const Size(414, 70), child: const SizedBox());

  final double height;

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: height,
      title: SizedBox(
        height: height,
        width: 50,
        child: FittedBox(
          fit: BoxFit.fitWidth,
          child: SvgPicture.asset(GlobalVariables.images.appIconPath),
        ),
      ),
      centerTitle: true,
      actions: const <Widget>[
        /*IconButton(
          onPressed: () {
            Get.changeTheme(Get.theme == Style.darkTheme ? Style.lightTheme : Style.darkTheme);
            WidgetsBinding.instance.performReassemble();
          },
          icon: Icon(Get.theme == Style.darkTheme ? Icons.wb_incandescent : Icons.wb_incandescent_outlined),
        ),*/
      ],
    );
  }
}
