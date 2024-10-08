import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:snapfeast/components/order.dart';
import 'package:snapfeast/components/transaction.dart';
import 'package:device_preview/device_preview.dart';
import 'package:snapfeast/misc/constants.dart';
import 'package:snapfeast/misc/providers.dart';
import 'package:snapfeast/misc/routes.dart';
import 'package:snapfeast/repositories/database_manager.dart';
import 'package:snapfeast/repositories/order_repository.dart';
import 'package:snapfeast/repositories/transaction_repository.dart';
import 'package:snapfeast/repositories/user_repository.dart';

import 'components/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await ScreenUtil.ensureScreenSize();
  await DatabaseManager.init();

  runApp(
     // DevicePreview(
    //   enabled: true,
    //   builder: (_) =>
       const ProviderScope(child: SnapFeast()),
     // ),
  );
}

class SnapFeast extends ConsumerStatefulWidget {
  const SnapFeast({super.key});

  @override
  ConsumerState<SnapFeast> createState() => _SnapFeastState();
}

class _SnapFeastState extends ConsumerState<SnapFeast>
    with WidgetsBindingObserver {
  late GoRouter router;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    router = GoRouter(initialLocation: Pages.onboard.path, routes: routes);

    Future.delayed(Duration.zero, load);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void load() {

  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (_, child) => MaterialApp.router(
        title: 'SnapFeast',
        themeMode: ThemeMode.light,
        theme: FlexColorScheme.light(
          scheme: FlexScheme.mandyRed,
          fontFamily: "Montserrat",
          useMaterial3: true,
        ).toTheme,
        routerConfig: router,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
      ),
      splitScreenMode: true,
      ensureScreenSize: true,
      useInheritedMediaQuery: true,
      designSize: const Size(390, 800),
      minTextAdapt: true,
    );
  }

}
