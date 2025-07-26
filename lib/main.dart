import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tt_vpn_app/controllers/theme_controllers.dart';
import 'package:tt_vpn_app/views/home_view.dart';
import 'package:tt_vpn_app/views/country_selection_view.dart';
import 'package:tt_vpn_app/views/settings_view.dart';
import 'package:tt_vpn_app/constants/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Bu satırı ekleyin
  
  // Storage'ı initialize et
  await GetStorage.init();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Theme controller'ı initialize et
    Get.put(ThemeController());
    
    return GetMaterialApp(
      title: 'TT VPN App',
      
      // Light Theme
      theme: ThemeData(
        fontFamily: "Gilroy",
        useMaterial3: true,
        brightness: Brightness.light,
        primaryColor: AppColors.primaryLight,
        scaffoldBackgroundColor: AppColors.backgroundLight,
        cardColor: AppColors.cardBackgroundLight,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.backgroundLight,
          foregroundColor: AppColors.textPrimaryLight,
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryLight,
            foregroundColor: AppColors.white,
          ),
        ),
        switchTheme: SwitchThemeData(
          thumbColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.selected)) {
              return AppColors.primaryLight;
            }
            return AppColors.light;
          }),
          trackColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.selected)) {
              return AppColors.primaryLight.withOpacity(0.5);
            }
            return AppColors.light.withOpacity(0.5);
          }),
        ),
      ),
      
      // Dark Theme
      darkTheme: ThemeData(
        fontFamily: "Gilroy",
        useMaterial3: true,
        brightness: Brightness.dark,
        primaryColor: AppColors.primaryDark,
        scaffoldBackgroundColor: AppColors.backgroundDark,
        cardColor: AppColors.cardBackgroundDark,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.backgroundDark,
          foregroundColor: AppColors.textPrimaryDark,
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryDark,
            foregroundColor: AppColors.white,
          ),
        ),
        switchTheme: SwitchThemeData(
          thumbColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.selected)) {
              return AppColors.primaryDark;
            }
            return AppColors.light;
          }),
          trackColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.selected)) {
              return AppColors.primaryDark.withOpacity(0.5);
            }
            return AppColors.light.withOpacity(0.5);
          }),
        ),
      ),
      
      // Tema modu
      themeMode: ThemeMode.system, // Başlangıçta sistem temasını kullan
      
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
  }
}