import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {
  static const String _themeKey = 'theme_mode';
  
  final _storage = GetStorage();
  final Rx<ThemeMode> _themeMode = ThemeMode.system.obs;
  
  ThemeMode get themeMode => _themeMode.value;
  bool get isDarkMode => _themeMode.value == ThemeMode.dark;
  bool get isLightMode => _themeMode.value == ThemeMode.light;
  bool get isSystemMode => _themeMode.value == ThemeMode.system;
  
  @override
  void onInit() {
    super.onInit();
    _loadThemeFromStorage();
  }
  
  // Storage'dan tema yükle
  void _loadThemeFromStorage() {
    final savedTheme = _storage.read(_themeKey);
    if (savedTheme != null) {
      // Eğer int değeri ise (ThemeMode.index), direkt kullan
      if (savedTheme is int && savedTheme >= 0 && savedTheme < ThemeMode.values.length) {
        _themeMode.value = ThemeMode.values[savedTheme];
      }
      // Eğer string değeri ise, parse et
      else if (savedTheme is String) {
        switch (savedTheme.toLowerCase()) {
          case 'light':
            _themeMode.value = ThemeMode.light;
            break;
          case 'dark':
            _themeMode.value = ThemeMode.dark;
            break;
          case 'system':
            _themeMode.value = ThemeMode.system;
            break;
          default:
            _themeMode.value = ThemeMode.system;
        }
      }
      // Eğer boolean değeri ise (eski format), dönüştür
      else if (savedTheme is bool) {
        _themeMode.value = savedTheme ? ThemeMode.dark : ThemeMode.light;
        // Yeni formata dönüştür ve kaydet
        _storage.write(_themeKey, _themeMode.value.index);
      }
    }
  }
  
  // Tema modunu değiştir
  void setThemeMode(ThemeMode mode) {
    _themeMode.value = mode;
    _storage.write(_themeKey, mode.index);
    Get.changeThemeMode(mode);
  }
  
  // Koyu temaya geç
  void setDarkMode() {
    setThemeMode(ThemeMode.dark);
  }
  
  // Açık temaya geç
  void setLightMode() {
    setThemeMode(ThemeMode.light);
  }
  
  // Sistem temasını kullan
  void setSystemMode() {
    setThemeMode(ThemeMode.system);
  }
  
  // Tema toggle (light/dark arasında)
  void toggleTheme() {
    if (_themeMode.value == ThemeMode.dark) {
      setLightMode();
    } else {
      setDarkMode();
    }
  }
  
  // Storage'ı temizle (debug için)
  void clearThemeStorage() {
    _storage.remove(_themeKey);
    _themeMode.value = ThemeMode.system;
  }
}