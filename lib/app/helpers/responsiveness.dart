import 'package:flutter/material.dart';

const int largeScreenSize = 1366;
const int mediumScreenSize = 768;
const int smallScreenSize = 360;
const int customScreenSize = 1100;

class ResponsiveWidget extends StatelessWidget {
  final Widget largeScreen, mediumScreen, smallScreen, customScreen;

  const ResponsiveWidget(
      {Key? key,
      required this.largeScreen,
      required this.mediumScreen,
      required this.smallScreen,
      required this.customScreen})
      : super(key: key);

  static bool isSmallScreen(BuildContext context) =>
      MediaQuery.of(context).size.width < smallScreenSize;

  static bool isMediumScreen(BuildContext context) =>
      MediaQuery.of(context).size.width >= mediumScreenSize &&
      MediaQuery.of(context).size.width < largeScreenSize;

  static bool isLargeScreen(BuildContext context) =>
      MediaQuery.of(context).size.width >= largeScreenSize;

  static bool isCustomScreen(BuildContext context) =>
      MediaQuery.of(context).size.width >= mediumScreenSize &&
      MediaQuery.of(context).size.width <= customScreenSize;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double _with = constraints.maxWidth;
      if(_with >= largeScreenSize) {
        return largeScreen;
      }
      else if(_with < largeScreenSize && _with >= mediumScreenSize) {
        return mediumScreen ?? largeScreen;
      }
      else {
        return smallScreen ?? largeScreen;
      }
    });
  }
}
