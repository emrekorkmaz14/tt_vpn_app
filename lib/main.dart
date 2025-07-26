import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tt_vpn_app/controllers/theme_controllers.dart';
import 'package:tt_vpn_app/views/home_view.dart';
import 'package:tt_vpn_app/views/country_selection_view.dart';
import 'package:tt_vpn_app/views/settings_view.dart';
import 'package:tt_vpn_app/constants/app_constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.put(ThemeController());
    return Obx(() {
      return GetMaterialApp(
        title: 'TT VPN App',
        theme: AppThemes.lightTheme,
        darkTheme: AppThemes.darkTheme,
        themeMode: themeController.themeMode,
        home: const HomeView(),
        getPages: [
          GetPage(name: '/', page: () => const HomeView()),
          GetPage(name: '/home', page: () => const HomeView()),
          GetPage(
              name: '/country-selection',
              page: () => const CountrySelectionView()),
          GetPage(name: '/settings', page: () => const SettingsView()),
        ],
        initialRoute: '/',
        debugShowCheckedModeBanner: false,
      );
    });
  }
}
