import 'package:go_router/go_router.dart';
import 'package:snapfeast/misc/constants.dart';
import 'package:snapfeast/pages/auth/camera.dart';
import 'package:snapfeast/pages/auth/details.dart';
import 'package:snapfeast/pages/auth/login.dart';
import 'package:snapfeast/pages/auth/register.dart';
import 'package:snapfeast/pages/home/landing_page.dart';
import 'package:snapfeast/pages/home/onboarding.dart';

final List<GoRoute> routes = [
  GoRoute(
    path: Pages.onboard.path,
    name: Pages.onboard,
    builder: (_, __) => const OnboardingPage(),
  ),
  GoRoute(
    path: Pages.login.path,
    name: Pages.login,
    builder: (_, __) => const LoginPage(),
  ),
  GoRoute(
    path: Pages.register.path,
    name: Pages.register,
    builder: (_, __) => const RegisterPage(),
  ),
  GoRoute(
    path: Pages.camera.path,
    name: Pages.camera,
    builder: (_, __) => const CameraPage(),
  ),
  GoRoute(
    path: Pages.home.path,
    name: Pages.home,
    builder: (_, __) => const LandingPage(),
  ),
  GoRoute(
    path: Pages.details.path,
    name: Pages.details,
    builder: (_, __) => const AccountDetailsPage(),
  ),
];
