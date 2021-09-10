import 'package:flutter_getx/features/bindings/detail_post_binding.dart';
import 'package:flutter_getx/features/bindings/home_binding.dart';
import 'package:flutter_getx/features/bindings/sign_in_binding.dart';
import 'package:flutter_getx/features/pages/detail_post_page.dart';
import 'package:flutter_getx/features/pages/file_picker_page.dart';
import 'package:flutter_getx/features/pages/home_page.dart';
import 'package:flutter_getx/features/pages/overlay_entry_helper.dart';
import 'package:flutter_getx/features/pages/notification_page.dart';
import 'package:flutter_getx/features/pages/sign_in_page.dart';
import 'package:flutter_getx/routes/app_routes.dart';
import 'package:get/route_manager.dart';

class AppPage {
  static final pages = [
    GetPage(
      name: AppRoute.home,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoute.detailPost,
      page: () => DetailPostPage(),
      binding: DetailPostBinding(),
    ),
    GetPage(
      name: AppRoute.filePickerPage,
      page: () => const FilePickerPage(),
    ),
    GetPage(
      name: AppRoute.notificationPage,
      page: () => const NotificationPage(),
    ),
    GetPage(
      name: AppRoute.signInPage,
      page: () => SignInPage(),
      binding: SignInBinding(),
    ),
    GetPage(
      name: AppRoute.overlayHelper,
      page: () => OverLayEntryHelper(),
    ),
  ];
}
