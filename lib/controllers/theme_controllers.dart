import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {
  static const String _themeKey = 'theme_mode';
  
  final _storage = GetStorage();
  final RxBool _isDarkMode = false.obs;
  
  bool get isDarkMode => _isDarkMode.value;
  
  @override
  void onInit() {
    super.onInit();
    _loadThemeFromStorage();
  }
  
  // Storage'dan tema yükle
  void _loadThemeFromStorage() {
    final savedTheme = _storage.read(_themeKey);
    if (savedTheme != null) {
      _isDarkMode.value = savedTheme;
      Get.changeThemeMode(_isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
    }
  }
  
  // Tema değiştir
  void toggleTheme() {
    _isDarkMode.value = !_isDarkMode.value;
    Get.changeThemeMode(_isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
    _storage.write(_themeKey, _isDarkMode.value);
  }
  
  // Belirli tema ayarla
  void setTheme(bool isDark) {
    _isDarkMode.value = isDark;
    Get.changeThemeMode(isDark ? ThemeMode.dark : ThemeMode.light);
    _storage.write(_themeKey, isDark);
  }
}