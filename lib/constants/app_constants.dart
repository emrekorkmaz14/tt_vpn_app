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
  static const Color medium = Color(0xFF999999);
  static const Color dark = Color(0xFF333333);
}

class AppThemes {
  static ThemeData get lightTheme {
    return ThemeData(
      fontFamily: "Gilroy",
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: AppColors.primaryLight,
      scaffoldBackgroundColor: AppColors.backgroundLight,
      cardColor: AppColors.cardBackgroundLight,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primaryLight,
        secondary: AppColors.primaryLight,
        background: AppColors.backgroundLight,
        surface: AppColors.cardBackgroundLight,
        onPrimary: AppColors.white,
        onSecondary: AppColors.white,
        onBackground: AppColors.textPrimaryLight,
        onSurface: AppColors.textPrimaryLight,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.backgroundLight,
        foregroundColor: AppColors.textPrimaryLight,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      cardTheme: CardThemeData(
        color: AppColors.cardBackgroundLight,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryLight,
          foregroundColor: AppColors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          ),
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
      iconTheme: const IconThemeData(
        color: AppColors.textSecondaryLight,
      ),
      textTheme: _buildTextTheme(
        AppColors.textPrimaryLight,
        AppColors.textSecondaryLight,
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      fontFamily: "Gilroy",
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: AppColors.primaryDark,
      scaffoldBackgroundColor: AppColors.backgroundDark,
      cardColor: AppColors.cardBackgroundDark,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primaryDark,
        secondary: AppColors.primaryDark,
        background: AppColors.backgroundDark,
        surface: AppColors.cardBackgroundDark,
        onPrimary: AppColors.white,
        onSecondary: AppColors.white,
        onBackground: AppColors.textPrimaryDark,
        onSurface: AppColors.textPrimaryDark,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.backgroundDark,
        foregroundColor: AppColors.textPrimaryDark,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      cardTheme: CardThemeData(
        color: AppColors.cardBackgroundDark,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryDark,
          foregroundColor: AppColors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          ),
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
      iconTheme: const IconThemeData(
        color: AppColors.textSecondaryDark,
      ),
      textTheme: _buildTextTheme(
        AppColors.textPrimaryDark,
        AppColors.textSecondaryDark,
      ),
    );
  }

  static TextTheme _buildTextTheme(Color primaryColor, Color secondaryColor) {
    return TextTheme(
      displayLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w800,
        color: primaryColor,
        fontFamily: 'Gilroy',
      ),
      displayMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: primaryColor,
        fontFamily: 'Gilroy',
      ),
      displaySmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: primaryColor,
        fontFamily: 'Gilroy',
      ),
      headlineLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: primaryColor,
        fontFamily: 'Gilroy',
      ),
      headlineMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: primaryColor,
        fontFamily: 'Gilroy',
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: primaryColor,
        fontFamily: 'Gilroy',
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: primaryColor,
        fontFamily: 'Gilroy',
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: secondaryColor,
        fontFamily: 'Gilroy',
      ),
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: secondaryColor,
        fontFamily: 'Gilroy',
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: secondaryColor,
        fontFamily: 'Gilroy',
      ),
    );
  }
}

// Helper extension
extension ThemeHelper on BuildContext {
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  Color get primaryColor => Theme.of(this).colorScheme.primary;
  Color get backgroundColor => Theme.of(this).colorScheme.background;
  Color get cardColor => Theme.of(this).colorScheme.surface;
  Color get textColor => Theme.of(this).colorScheme.onBackground;
}

// Animasyon Süreleri
class AppDurations {
  static const Duration fast = Duration(milliseconds: 200);
  static const Duration medium = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 500);
  static const Duration verySlow = Duration(milliseconds: 800);
  static const Duration connectionAnimation = Duration(milliseconds: 1000);
  static const Duration pageTransition = Duration(milliseconds: 300);
}

// Asset Path'leri
class AppAssets {
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

  static const String flagsPath = 'assets/flags/';
  static const String flagItaly = '${flagsPath}italy.png';
  static const String flagNetherlands = '${flagsPath}netherlands.png';
  static const String flagGermany = '${flagsPath}germany.png';

  static const String imagesPath = 'assets/images/';
}

// String Sabitler
class AppStrings {
  static const String appName = 'TT VPN';
  static const String countries = 'Countries';
  static const String settings = 'Settings';
  static const String disconnect = 'Disconnect';
  static const String searchHint = 'Search For Country Or City';
  static const String connectingTime = 'Connecting Time';
  static const String download = 'Download :';
  static const String upload = 'Upload :';
  static const String freeLocations = 'Free Locations';
  static const String stealth = 'Stealth';
  static const String connected = 'Connected';
  static const String connecting = 'Connecting';
  static const String disconnected = 'Disconnected';
  static const String italy = 'Italy';
  static const String netherlands = 'Netherlands';
  static const String germany = 'Germany';
  static const String amsterdam = 'Amsterdam';
  static const String mbUnit = 'MB';
  static const String locations = 'Locations';
  static const String location = 'Location';
  static const String connectionError = 'Connection Error';
  static const String noInternetConnection = 'No Internet Connection';
  static const String serverNotAvailable = 'Server Not Available';
  static const String selectCountry = 'Select Country';
  static const String availableCountries = 'Available Countries';
  static const String noCountriesFound = 'No countries found';
  static const String tryDifferentSearch = 'Try a different search term';
  static const String clearSearch = 'Clear Search';
  static const String appearance = 'Appearance';
  static const String vpnSettings = 'VPN Settings';
  static const String general = 'General';
  static const String about = 'About';
  static const String lightTheme = 'Light Theme';
  static const String darkTheme = 'Dark Theme';
  static const String systemTheme = 'System Theme';
  static const String autoConnect = 'Auto Connect';
  static const String autoConnectDescription =
      'Automatically connect when app starts';
  static const String killSwitch = 'Kill Switch';
  static const String killSwitchDescription =
      'Block internet if VPN disconnects';
  static const String protocol = 'Protocol';
  static const String protocolDescription = 'Choose VPN protocol';
  static const String notifications = 'Notifications';
  static const String notificationsDescription =
      'Receive connection status notifications';
  static const String aboutApp = 'About App';
  static const String aboutAppDescription = 'Version and app information';
  static const String aboutDescription =
      'A secure and fast VPN application built with Flutter.';
  static const String clearData = 'Clear All Data';
  static const String clearDataDescription =
      'This will remove all app data and reset settings to default.';
  static const String clearDataShortDescription =
      'Reset app to default settings';
  static const String close = 'Close';
  static const String cancel = 'Cancel';
  static const String clear = 'Clear';
  static const String success = 'Success';
  static const String dataCleared = 'All data has been cleared successfully';
}

// App Constants
class AppConstants {
  static const int timerUpdateInterval = 1;
  static const int speedUpdateInterval = 2;
  static const int maxCountryListItems = 50;
  static const int searchDebounceTime = 300;
  static const int connectionTimeout = 30;
  static const int maxConnectionRetries = 3;
}

// Boyutlar ve Spacing
class AppDimensions {
  static const double paddingXS = 4.0;
  static const double paddingS = 8.0;
  static const double paddingM = 16.0;
  static const double paddingL = 24.0;
  static const double paddingXL = 32.0;
  static const double paddingXXL = 64.0;

  static const double marginXS = 4.0;
  static const double marginS = 8.0;
  static const double marginM = 16.0;
  static const double marginL = 24.0;
  static const double marginXL = 32.0;

  static const double radiusS = 6.0;
  static const double radiusM = 12.0;
  static const double radiusL = 16.0;
  static const double radiusXL = 24.0;
  static const double radiusCircle = 50.0;

  static const double iconXS = 16.0;
  static const double iconS = 20.0;
  static const double iconM = 24.0;
  static const double iconL = 36.0;
  static const double iconXL = 48.0;
  static const double iconNavBar = 28.0;

  static const double buttonHeight = 48.0;
  static const double buttonHeightSmall = 36.0;
  static const double buttonHeightLarge = 56.0;

  static const double elevationS = 2.0;
  static const double elevationM = 4.0;
  static const double elevationL = 8.0;

  static const double searchBarHeight = 64.0;
  static const double flagHeight = 32.0;
  static const double flagWidth = 42.0;
}
