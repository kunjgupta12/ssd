import 'package:flutter/material.dart';

import '../../../theme/theme_helper.dart';

// ignore: must_be_immutable
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar({
    Key? key,
    this.height,
    this.styleType,
    this.leadingWidth,
    this.leading,
    this.title,
    this.centerTitle,
    this.actions,
  }) : super(
          key: key,
        );

  final double? height;

  final Style? styleType;

  final double? leadingWidth;

  final Widget? leading;

  final Widget? title;

  final bool? centerTitle;

  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      toolbarHeight: height ?? 84,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      flexibleSpace: _getStyle(),
      leadingWidth: leadingWidth ?? 0,
      leading: leading,
      title: title,
      titleSpacing: 0,
      centerTitle: centerTitle ?? false,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size(height ?? 84, 25);
  _getStyle() {
    switch (styleType) {
      case Style.bgGradientnamelightgreenA700namegreen800aa:
        return Container(
          height: 84,
          width: double.maxFinite,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(0.93, 0.25),
              end: Alignment(0.04, 1),
              colors: [
                appTheme.lightGreenA700,
                appTheme.green800Aa,
              ],
            ),
          ),
        );
      default:
        return null;
    }
  }
}

enum Style {
  bgGradientnamelightgreenA700namegreen800aa,
}
