import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:snapfeast/misc/constants.dart';
import 'package:snapfeast/misc/routes.dart';



void main() async {
  await ScreenUtil.ensureScreenSize();
  runApp(const ProviderScope(child: SnapFeast()));
}

class SnapFeast extends StatefulWidget {
  const SnapFeast({super.key});

  @override
  State<SnapFeast> createState() => _SnapFeastState();
}

class _SnapFeastState extends State<SnapFeast> {

  late GoRouter router;

  @override
  void initState() {
    super.initState();
    router = GoRouter(
      initialLocation: Pages.onboard.path,
      routes: routes
    );
  }


  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (_, child) => MaterialApp.router(
        title: 'SnapFeast',
        themeMode: ThemeMode.dark,
        darkTheme: FlexColorScheme.dark(
            scheme: FlexScheme.orangeM3,
          fontFamily: "Montserrat",
        ).toTheme,
        routerConfig: router,
      ),
      splitScreenMode: true,
      ensureScreenSize: true,
      useInheritedMediaQuery: true,
      designSize: const Size(390, 800),
      minTextAdapt: true,
    );
  }
}