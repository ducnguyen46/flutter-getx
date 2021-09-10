import 'package:flutter/material.dart';
import 'package:flutter_getx/data_source/local/notification_service.dart';
import 'package:flutter_getx/resources/translate/translator.dart';
import 'package:flutter_getx/routes/app_pages.dart';
import 'package:flutter_getx/routes/app_routes.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: Translator(),
      locale: Translator.getLocale(),
      fallbackLocale: Translator.fallbackLocale,
      initialRoute: AppRoute.home,
      getPages: AppPage.pages,
    );
  }
}
