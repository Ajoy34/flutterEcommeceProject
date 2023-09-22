import 'package:ecommerce/business_logics/bindings/auth_binding.dart';
import 'package:ecommerce/business_logics/bindings/cart_binding.dart';
import 'package:ecommerce/business_logics/bindings/favourite_binding.dart';
import 'package:ecommerce/business_logics/bindings/splash_binding.dart';
import 'package:ecommerce/ui/views/auth/forgetpassword.dart';
import 'package:ecommerce/ui/views/auth/login.dart';
import 'package:ecommerce/ui/views/auth/registration.dart';
import 'package:ecommerce/ui/views/auth/term_condition.dart';
import 'package:ecommerce/ui/views/bottom_nav_controller.dart';
import 'package:ecommerce/ui/views/nav_pages/home.dart';
import 'package:ecommerce/ui/views/not_found.dart';
import 'package:ecommerce/ui/views/onboarding.dart';
import 'package:ecommerce/ui/views/splash.dart';

import 'package:get/get.dart';

const String splash = '/splash-screen';
const String unknown = '/not-found';
const String intro = '/intro';
const String login = '/login';
const String registration = '/registration';
const String forgetPass = '/forgetPass';
const String terms = '/terms';
const String bottomNav = '/bottomNav';
const String details = '/details';

List<GetPage> getPages = [
  GetPage(
    name: unknown,
    page: () => const Unknown(),
  ),
  GetPage(
    name: splash,
    page: () => Splash(),
    binding: SplashBinding(),
  ),
  GetPage(
    name: intro,
    page: () => const Onboarding(),
  ),
  GetPage(name: login, page: () => Login(), binding: AuthBinding()),
  GetPage(
      name: registration, page: () => Registration(), binding: AuthBinding()),
  GetPage(
    name: forgetPass,
    page: () => ForgetPassword(),
    binding: AuthBinding(),
  ),
  GetPage(
    name: terms,
    page: () => TermCondition(),
  ),
  GetPage(name: bottomNav, page: () => BottomNavController(), bindings: [
    CartBinding(),
    FavouriteBinding(),
  ]),
  GetPage(
    name: details,
    page: () => DetailsScreen(
      data: Get.arguments,
    ),
  ),
];