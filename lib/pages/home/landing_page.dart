import 'package:animated_switcher_plus/animated_switcher_plus.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapfeast/misc/constants.dart';
import 'package:snapfeast/misc/functions.dart';
import 'package:snapfeast/misc/providers.dart';
import 'package:snapfeast/pages/home/home.dart';
import 'package:snapfeast/pages/home/food.dart';
import 'package:snapfeast/pages/home/profile.dart';
import 'package:snapfeast/pages/home/wallet.dart';

class LandingPage extends ConsumerStatefulWidget {
  const LandingPage({super.key});

  @override
  ConsumerState<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends ConsumerState<LandingPage> {
  late List<Widget> children;

  @override
  void initState() {
    super.initState();
    children = const [
      Homepage(),
      OrdersPage(),
      WalletPage(),
      ProfilePage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    int index = ref.watch(dashboardIndex);
    String image = ref.watch(userProvider).email;

    return PopScope(
      canPop: false,
      onPopInvoked: (shouldPop) => false,
      child: Scaffold(
        body: IndexedStack(
          index: index,
          children: children,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: index,
          onTap: (page) => ref.watch(dashboardIndex.notifier).state = page,
          selectedItemColor: p400,
          unselectedItemColor: p150,
          selectedLabelStyle: TextStyle(
            fontFamily: "Montserrat",
            fontSize: 14.sp,
            color: p400,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: TextStyle(
            fontFamily: "Montserrat",
            fontSize: 14.sp,
            color: p150,
            fontWeight: FontWeight.normal,
          ),
          elevation: 0,
          items: [
            BottomNavigationBarItem(
              icon: AnimatedSwitcherZoom.zoomIn(
                duration: const Duration(milliseconds: 300),
                child: Icon(
                  Icons.home,
                  color: index == 0 ? p400 : p150,
                  key: ValueKey<bool>(index == 0),
                ),
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: AnimatedSwitcherZoom.zoomIn(
                duration: const Duration(milliseconds: 300),
                child: Icon(
                  Icons.fastfood_rounded,
                  color: index == 1 ? p400 : p150,
                  key: ValueKey<bool>(index == 1),
                ),
              ),
              label: "Food",
            ),
            BottomNavigationBarItem(
              icon: AnimatedSwitcherZoom.zoomIn(
                duration: const Duration(milliseconds: 300),
                child: Icon(
                  Icons.wallet,
                  color: index == 2 ? p400 : p150,
                  key: ValueKey<bool>(index == 2),
                ),
              ),
              label: "Wallet",
            ),
            BottomNavigationBarItem(
              icon: AnimatedSwitcherZoom.zoomIn(
                duration: const Duration(milliseconds: 300),
                child: CachedNetworkImage(
                  key: ValueKey<bool>(index == 3),
                  imageUrl: roboImage(image),
                  errorWidget: (_, __, c) => CircleAvatar(
                    radius: 20.r,
                    backgroundColor: Colors.white24,
                    child: Icon(
                      Icons.person,
                      color: p100,
                      size: 10.r,
                    ),
                  ),
                  progressIndicatorBuilder: (_, __, c) => CircleAvatar(
                    radius: 20.r,
                    backgroundColor: Colors.white24,
                  ),
                  imageBuilder: (_, provider) => GestureDetector(
                    onTap: () => ref.watch(dashboardIndex.notifier).state = 3,
                    child: CircleAvatar(
                      backgroundImage: provider,
                      radius: 16.r,
                    ),
                  ),
                ),
              ),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}
