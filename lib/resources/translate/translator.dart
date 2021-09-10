import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'vi_vn.dart';
import 'en_us.dart';

class Translator extends Translations {
  static final locale = getLocale();

  static final Map<String, Locale> supportLocale = LinkedHashMap.from({
    'en': const Locale('en', 'US'),
    'vi': const Locale('vi', 'VN'),
  });

  static final dropdownLang = LinkedHashMap<String, Widget>.from({
    'en': const Icon(Icons.settings),
    'vi': const Icon(Icons.camera),
  });

  // fallbackLocale là locale default nếu locale được set không nằm trong những Locale support
  static const fallbackLocale = Locale('en', 'US');

  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': en,
        'vi_VN': vi,
      };

  static Locale getLocale({String? langCode}) {
    if (langCode == null) {
      return Get.deviceLocale ?? supportLocale.values.first;
    } else {
      List<Locale> locales = supportLocale.values.toList();
      List<String> keys = supportLocale.keys.toList();
      for (int index = 0; index < keys.length; index++) {
        if (langCode == keys[index]) {
          return locales[index];
        }
      }
      return supportLocale.values.first;
    }
  }

  static changeLocale(String langCode) {
    var locale = getLocale(langCode: langCode);
    Get.updateLocale(locale);
  }
}
