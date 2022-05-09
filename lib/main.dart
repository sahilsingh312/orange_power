import 'package:flutter/material.dart';
import 'package:orange_power/locator.dart';
import 'package:orange_power/ui/themes/custom_theme.dart';
import 'package:orange_power/ui/views/home_screen.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, widget) => ResponsiveWrapper.builder(
        BouncingScrollWrapper.builder(context, widget!),
        maxWidth: 1200,
        minWidth: 450,
        defaultScale: true,
        breakpoints: [
          const ResponsiveBreakpoint.resize(450, name: MOBILE),
          const ResponsiveBreakpoint.autoScale(800, name: TABLET),
          const ResponsiveBreakpoint.autoScale(1000, name: TABLET),
          const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
          const ResponsiveBreakpoint.autoScale(2460, name: "4K"),
        ],
        breakpointsLandscape: [
          const ResponsiveBreakpoint.autoScaleDown(
            400,
            name: MOBILE,
            scaleFactor: 0.7,
          ),
          const ResponsiveBreakpoint.autoScale(
            680,
            name: TABLET,
            scaleFactor: 0.7,
          ),
          // const ResponsiveBreakpoint.autoScale(1100, name: DESKTOP, scaleFactor: 0.5),
        ],
      ),
      debugShowCheckedModeBanner: false,
      theme: CustomTheme.mainTheme,
      home: const HomeScreen(),
    );
  }
}
