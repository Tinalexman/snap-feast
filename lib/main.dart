import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:snapfeast/components/order.dart';
import 'package:snapfeast/components/transaction.dart';
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

  runApp(const ProviderScope(child: SnapFeast()));
}

class SnapFeast extends ConsumerStatefulWidget {
  const SnapFeast({super.key});

  @override
  ConsumerState<SnapFeast> createState() => _SnapFeastState();
}

class _SnapFeastState extends ConsumerState<SnapFeast> with WidgetsBindingObserver {

  late GoRouter router;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    router = GoRouter(
      initialLocation: Pages.onboard.path,
      routes: routes
    );

    Future.delayed(const Duration(seconds: 1), load);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (_, child) => MaterialApp.router(
        title: 'SnapFeast',
        themeMode: ThemeMode.system,
        darkTheme: FlexColorScheme.light(
            scheme: FlexScheme.mandyRed,
          fontFamily: "Montserrat",
          useMaterial3: true,
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

  Future<void> load() async {
    List<Transaction> transactions = ref.watch(transactionsProvider);
    List<FoodOrder> orders = ref.watch(foodOrdersProvider);
    User user = ref.watch(userProvider);

    OrderRepository orderRepository = GetIt.I.get();
    await orderRepository.deleteAll();
    await orderRepository.addAll(orders);

    TransactionRepository transactionRepository = GetIt.I.get();
    await transactionRepository.deleteAll();
    await transactionRepository.addAll(transactions);

    UserRepository userRepository = GetIt.I.get();
    await userRepository.saveMainUser(user);
  }

  Future<void> save() async {
    OrderRepository orderRepository = GetIt.I.get();
    TransactionRepository transactionRepository = GetIt.I.get();
    UserRepository userRepository = GetIt.I.get();

    List<FoodOrder> orders = await orderRepository.getAll();
    List<Transaction> transactions = await transactionRepository.getAll();
    User? user = await userRepository.getMainUser();

    ref.watch(foodOrdersProvider.notifier).state.clear();
    ref.watch(foodOrdersProvider.notifier).state.addAll(orders);

    ref.watch(transactionsProvider.notifier).state.clear();
    ref.watch(transactionsProvider.notifier).state.addAll(transactions);

    if(user != null) {
      ref.watch(userProvider.notifier).state = user;
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      await load();
    } else if (state == AppLifecycleState.resumed) {
      await save();
    }
  }

}