import 'package:go_router/go_router.dart';
import 'package:snapfeast/misc/constants.dart';
import 'package:snapfeast/pages/home/onboarding.dart';

final List<GoRoute> routes = [
  GoRoute(
    path: Pages.onboard.path,
    name: Pages.onboard,
    builder: (_, __) => const OnboardingPage(),
  ),
];
