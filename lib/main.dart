import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tt_vpn_app/controllers/theme_controllers.dart';
import 'package:tt_vpn_app/views/home_view.dart';
import 'package:tt_vpn_app/views/country_selection_view.dart';
import 'package:tt_vpn_app/views/settings_view.dart';
import 'package:tt_vpn_app/constants/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Storage'ı initialize et
  await GetStorage.init();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Theme controller'ı initialize et
    final themeController = Get.put(ThemeController());
    
    return Obx(() {
      return GetMaterialApp(
        title: 'TT VPN App',
        
        // Light Theme
        theme: AppThemes.lightTheme,
        
        // Dark Theme
        darkTheme: AppThemes.darkTheme,
        
        // Tema modu - ThemeController'dan gelir
        themeMode: themeController.themeMode,
        
        home: const HomeView(),
        
        getPages: [
          GetPage(name: '/', page: () => const HomeView()),
          GetPage(name: '/home', page: () => const HomeView()),
          GetPage(name: '/country-selection', page: () => const CountrySelectionView()),
          GetPage(name: '/settings', page: () => const SettingsView()),
        ],
        
        initialRoute: '/',
        debugShowCheckedModeBanner: false,
      );
    });
  }
}