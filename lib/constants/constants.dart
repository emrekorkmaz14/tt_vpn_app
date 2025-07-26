import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppColors {
  // Light Theme Colors
  static const Color primaryLight = Color(0xFF1A5CFF);
  static const Color backgroundLight = Color(0xFFF2F5F9);
  static const Color cardBackgroundLight = Color(0xFFFFFFFF);
  static const Color textPrimaryLight = Color(0xFF333333);
  static const Color textSecondaryLight = Color(0xFF666666);
  static const Color textHintLight = Color(0xFF999999);

  // Dark Theme Colors
  static const Color primaryDark = Color(0xFF4A7FFF);
  static const Color backgroundDark = Color(0xFF121212);
  static const Color cardBackgroundDark = Color(0xFF1E1E1E);
  static const Color textPrimaryDark = Color(0xFFFFFFFF);
  static const Color textSecondaryDark = Color(0xFFBBBBBB);
  static const Color textHintDark = Color(0xFF777777);

  // Static Colors (tema bağımsız)
  static const Color connected = Color(0xFF00D589);
  static const Color disconnected = Color(0xFFE63946);
  static const Color connecting = Color(0xFFFF9500);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF00091F);
  static const Color shadow = Color(0x1A000000);
  static const Color light = Color(0xFFCCCCCC);

  // Dynamic Colors (tema bağımlı) - Bu getter'lar çok önemli!
  static Color get primary => Get.isDarkMode ? primaryDark : primaryLight;
  static Color get background =>
      Get.isDarkMode ? backgroundDark : backgroundLight;
  static Color get cardBackground =>
      Get.isDarkMode ? cardBackgroundDark : cardBackgroundLight;
  static Color get textPrimary =>
      Get.isDarkMode ? textPrimaryDark : textPrimaryLight;
  static Color get textSecondary =>
      Get.isDarkMode ? textSecondaryDark : textSecondaryLight;
  static Color get textHint => Get.isDarkMode ? textHintDark : textHintLight;

  // Geriye uyumluluk için eski isimler
  static Color get dark => textPrimary;
  static Color get medium => textSecondary;
}

// TextStyle'ları da dinamik hale getirin
class AppTextStyles {
  static TextStyle get h1 => TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w800,
        color: AppColors.textPrimary,
        fontFamily: 'Gilroy',
      );

  static TextStyle get h2 => TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        fontFamily: 'Gilroy',
      );

  static TextStyle get h3 => TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        fontFamily: 'Gilroy',
      );

  static TextStyle get bodyLarge => TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
        fontFamily: 'Gilroy',
      );

  static TextStyle get bodyMedium => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
        fontFamily: 'Gilroy',
      );

  static TextStyle get caption => TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
        fontFamily: 'Gilroy',
      );

  static TextStyle get searchHint => TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.textHint,
        fontFamily: 'Gilroy',
      );

  static TextStyle get label => TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: AppColors.textSecondary,
        fontFamily: 'Gilroy',
      );

  static TextStyle get timerText => TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        fontFamily: 'Gilroy',
      );

  static TextStyle get countryName => TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        fontFamily: 'Gilroy',
      );

  static TextStyle get cityName => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
        fontFamily: 'Gilroy',
      );

  static TextStyle get speedText => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        fontFamily: 'Gilroy',
      );
}

// Animasyon Süreleri
class AppDurations {
  static const Duration fast = Duration(milliseconds: 200);
  static const Duration medium = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 500);
  static const Duration verySlow = Duration(milliseconds: 800);

  // Bağlantı animasyonu
  static const Duration connectionAnimation = Duration(milliseconds: 1000);

  // Sayfa geçiş animasyonu
  static const Duration pageTransition = Duration(milliseconds: 300);
}

// Asset Path'leri
class AppAssets {
  // Icons
  static const String iconsPath = 'assets/icons/';
  static const String iconSearch = '${iconsPath}search.svg';
  static const String iconTimer = '${iconsPath}timer.svg';
  static const String iconImport = '${iconsPath}import.svg';
  static const String iconExport = '${iconsPath}export.svg';
  static const String iconCategory = '${iconsPath}category.svg';
  static const String iconMap = '${iconsPath}map.svg';
  static const String iconCrown = '${iconsPath}crown.svg';
  static const String iconSetting = '${iconsPath}setting.svg';
  static const String iconArrowRight = '${iconsPath}arrow-right.svg';
  static const String iconRadar = '${iconsPath}radar.svg';

  // Flags
  static const String flagsPath = 'assets/flags/';
  static const String flagItaly = '${flagsPath}italy.png';
  static const String flagNetherlands = '${flagsPath}netherlands.png';
  static const String flagGermany = '${flagsPath}germany.png';

  // Images
  static const String imagesPath = 'assets/images/';
}

// String Sabitler
class AppStrings {
  // Genel
  static const String appName = 'TT VPN';
  static const String countries = 'Countries';
  static const String settings = 'Settings';
  static const String disconnect = 'Disconnect';

  // Ana Ekran
  static const String searchHint = 'Search For Country Or City';
  static const String connectingTime = 'Connecting Time';
  static const String download = 'Download :';
  static const String upload = 'Upload :';
  static const String freeLocations = 'Free Locations';
  static const String stealth = 'Stealth';

  // Bağlantı Durumları
  static const String connected = 'Connected';
  static const String connecting = 'Connecting';
  static const String disconnected = 'Disconnected';

  // Ülke ve Şehir İsimleri
  static const String italy = 'Italy';
  static const String netherlands = 'Netherlands';
  static const String germany = 'Germany';
  static const String amsterdam = 'Amsterdam';

  // Birimler
  static const String mbUnit = 'MB';
  static const String locations = 'Locations';
  static const String location = 'Location';

  // Hata Mesajları
  static const String connectionError = 'Connection Error';
  static const String noInternetConnection = 'No Internet Connection';
  static const String serverNotAvailable = 'Server Not Available';

  // Select Country
  static const String selectCountry = 'Select Country';
  static const String availableCountries = 'Available Countries';
  static const String noCountriesFound = 'No countries found';
  static const String tryDifferentSearch = 'Try a different search term';
  static const String clearSearch = 'Clear Search';

  // Settings
  static const String appearance = 'Appearance';
  static const String vpnSettings = 'VPN Settings';
  static const String general = 'General';
  static const String about = 'About';

  // Theme
  static const String lightTheme = 'Light Theme';
  static const String darkTheme = 'Dark Theme';

  // VPN Settings
  static const String autoConnect = 'Auto Connect';
  static const String autoConnectDescription =
      'Automatically connect when app starts';
  static const String killSwitch = 'Kill Switch';
  static const String killSwitchDescription =
      'Block internet if VPN disconnects';
  static const String protocol = 'Protocol';
  static const String protocolDescription = 'Choose VPN protocol';

  // General
  static const String notifications = 'Notifications';
  static const String notificationsDescription =
      'Receive connection status notifications';

  // About
  static const String aboutApp = 'About App';
  static const String aboutAppDescription = 'Version and app information';
  static const String aboutDescription =
      'A secure and fast VPN application built with Flutter.';
  static const String clearData = 'Clear All Data';
  static const String clearDataDescription =
      'This will remove all app data and reset settings to default.';
  static const String clearDataShortDescription =
      'Reset app to default settings';

  // Actions
  static const String close = 'Close';
  static const String cancel = 'Cancel';
  static const String clear = 'Clear';
  static const String success = 'Success';
  static const String dataCleared = 'All data has been cleared successfully';
}

// Uygulama Sabitleri
class AppConstants {
  // Zamanlayıcı
  static const int timerUpdateInterval = 1; // seconds

  // Hız güncelleme aralığı
  static const int speedUpdateInterval = 2; // seconds

  // Maksimum ülke listesi
  static const int maxCountryListItems = 50;

  // Arama debounce süresi
  static const int searchDebounceTime = 300; // milliseconds

  // Bağlantı timeout süresi
  static const int connectionTimeout = 30; // seconds

  // Maksimum bağlantı denemesi
  static const int maxConnectionRetries = 3;
}

// Boyutlar ve Spacing
class AppDimensions {
  // Padding değerleri
  static const double paddingXS = 4.0;
  static const double paddingS = 8.0;
  static const double paddingM = 16.0;
  static const double paddingL = 24.0;
  static const double paddingXL = 32.0;
  static const double paddingXXL = 64.0;

  // Margin değerleri
  static const double marginXS = 4.0;
  static const double marginS = 8.0;
  static const double marginM = 16.0;
  static const double marginL = 24.0;
  static const double marginXL = 32.0;

  // Border Radius değerleri
  static const double radiusS = 6.0;
  static const double radiusM = 12.0;
  static const double radiusL = 16.0;
  static const double radiusXL = 24.0;
  static const double radiusCircle = 50.0;

  // Icon boyutları
  static const double iconXS = 16.0;
  static const double iconS = 20.0;
  static const double iconM = 24.0;
  static const double iconL = 36.0;
  static const double iconXL = 48.0;
  static const double iconNavBar = 28.0;

  // Button boyutları
  static const double buttonHeight = 48.0;
  static const double buttonHeightSmall = 36.0;
  static const double buttonHeightLarge = 56.0;

  // Card elevation
  static const double elevationS = 2.0;
  static const double elevationM = 4.0;
  static const double elevationL = 8.0;

  // Search bar height
  static const double searchBarHeight = 64.0;

  // Flag boyutu
  static const double flagHeight = 32.0;
  static const double flagWidth = 42.0;
}
