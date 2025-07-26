import 'dart:async';
import 'dart:math';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:tt_vpn_app/models/country_model.dart';
import 'package:tt_vpn_app/data/mockdata.dart';
import 'package:tt_vpn_app/constants/constants.dart';

enum ConnectionStatus { disconnected, connecting, connected }

class HomeController extends GetxController {
  // Reactive variables
  final Rx<ConnectionStatus> connectionStatus =
      ConnectionStatus.disconnected.obs;
  final Rx<Country?> connectedCountry = Rx<Country?>(null);
  final RxList<Country> countries = <Country>[].obs;
  final RxList<Country> filteredCountries = <Country>[].obs;
  final RxString searchQuery = ''.obs;
  final RxInt downloadSpeed = 0.obs;
  final RxInt uploadSpeed = 0.obs;
  final Rx<Duration> connectionDuration = Duration.zero.obs;
  final RxBool isSearchActive = false.obs;
  final RxInt selectedBottomNavIndex = 0.obs;
  final RxString connectingCountryName = ''.obs;

  // Controllers
  final TextEditingController searchController = TextEditingController();
  Timer? _connectionTimer;
  Timer? _speedUpdateTimer;

  @override
  void onInit() {
    super.onInit();
    _initializeData();
    _setupSearchListener();
  }

  @override
  void onClose() {
    searchController.dispose();
    _connectionTimer?.cancel();
    _speedUpdateTimer?.cancel();
    super.onClose();
  }

  // Initialize mock data
  void _initializeData() {
    countries.addAll(mockCountries);
    filteredCountries.addAll(mockCountries);

    // Set initial connected country if exists
    final connectedCountryData = mockConnectionStats.connectedCountry;
    if (connectedCountryData != null) {
      connectedCountry.value = connectedCountryData;
      connectionStatus.value = ConnectionStatus.connected;
      downloadSpeed.value = mockConnectionStats.downloadSpeed;
      uploadSpeed.value = mockConnectionStats.uploadSpeed;
      connectionDuration.value = mockConnectionStats.connectedTime;

      // Start timers
      _startConnectionTimer();
      _startSpeedUpdateTimer();
    }
  }

  // Setup search listener
  void _setupSearchListener() {
    searchController.addListener(() {
      searchQuery.value = searchController.text;
      _filterCountries();
    });
  }

  // Filter countries based on search query
  void _filterCountries() {
    if (searchQuery.value.isEmpty) {
      filteredCountries.assignAll(countries);
    } else {
      final query = searchQuery.value.toLowerCase();
      filteredCountries.assignAll(
        countries
            .where((country) =>
                country.name.toLowerCase().contains(query) ||
                (country.city?.toLowerCase().contains(query) ?? false))
            .toList(),
      );
    }
  }

// Connect to a country metodunu şu şekilde güncelleyin
  Future<void> connectToCountry(Country country) async {
    if (connectingCountryName.value.isNotEmpty) {
      return; // Başka bir ülke bağlanıyorsa
    }

    // ÖNCE connecting state'i ayarla
    connectingCountryName.value = country.name;

    // Disconnect current country if connected
    if (connectionStatus.value == ConnectionStatus.connected) {
      // Disconnect işlemini sessizce yap - UI'da connecting göster
      connectionStatus.value = ConnectionStatus.disconnected;

      // Update country connection status
      if (connectedCountry.value != null) {
        _updateCountryConnectionStatus(connectedCountry.value!, false);
      }

      connectedCountry.value = null;
      _resetConnectionStats();
      _stopTimers();

      // Kısa bekleme süresi - ama UI'da connecting görünür
      await Future.delayed(
          const Duration(milliseconds: 300)); // 500'den 300'e düşürdük
    }

    try {
      // Simulate connection process
      await Future.delayed(const Duration(seconds: 2));

      // Update country connection status
      _updateCountryConnectionStatus(country, true);

      connectionStatus.value = ConnectionStatus.connected;
      connectedCountry.value = country;

      // Start timers
      _startConnectionTimer();
      _startSpeedUpdateTimer();
    } catch (e) {
      connectionStatus.value = ConnectionStatus.disconnected;
      Get.snackbar(
        'Connection Failed',
        'Failed to connect to ${country.name}',
        backgroundColor: AppColors.disconnected,
        colorText: AppColors.white,
        duration: const Duration(seconds: 2),
      );
    } finally {
      connectingCountryName.value = ''; // Bağlantı işlemi bitti
    }
  }

  // Disconnect metodunu da güncelleyin
  Future<void> disconnect() async {
    if (connectionStatus.value == ConnectionStatus.disconnected) return;

    connectionStatus.value = ConnectionStatus.disconnected;
    connectingCountryName.value = ''; // Reset connecting state

    // Update country connection status
    if (connectedCountry.value != null) {
      _updateCountryConnectionStatus(connectedCountry.value!, false);
    }

    connectedCountry.value = null;
    _resetConnectionStats();
    _stopTimers();
  }

  // Update country connection status in the list
  void _updateCountryConnectionStatus(Country country, bool isConnected) {
    // Reset all countries
    for (var c in countries) {
      c.isConnected = false;
    }

    // Set the selected country as connected
    if (isConnected) {
      final index = countries.indexWhere((c) => c.name == country.name);
      if (index != -1) {
        countries[index].isConnected = true;
      }
    }

    // Update filtered list
    _filterCountries();
  }

  // Reset connection statistics
  void _resetConnectionStats() {
    downloadSpeed.value = 0;
    uploadSpeed.value = 0;
    connectionDuration.value = Duration.zero;
  }

  // Start connection timer
  void _startConnectionTimer() {
    _connectionTimer?.cancel();
    _connectionTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (connectionStatus.value == ConnectionStatus.connected) {
        connectionDuration.value =
            Duration(seconds: connectionDuration.value.inSeconds + 1);
      }
    });
  }

  // Start speed update timer
  void _startSpeedUpdateTimer() {
    _speedUpdateTimer?.cancel();
    _speedUpdateTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (connectionStatus.value == ConnectionStatus.connected) {
        _updateSpeedValues();
      }
    });
  }

  // Stop all timers
  void _stopTimers() {
    _connectionTimer?.cancel();
    _speedUpdateTimer?.cancel();
  }

  // Update speed values with realistic fluctuations
  void _updateSpeedValues() {
    final random = Random();

    // Download speed fluctuation (around base value)
    final baseDownload = connectedCountry.value?.strength ?? 70;
    final downloadVariation =
        (baseDownload * 0.3 * (random.nextDouble() - 0.5)).round();
    downloadSpeed.value =
        (baseDownload * 7 + downloadVariation).clamp(100, 1000);

    // Upload speed fluctuation (typically lower than download)
    final baseUpload = (downloadSpeed.value * 0.1).round();
    final uploadVariation =
        (baseUpload * 0.5 * (random.nextDouble() - 0.5)).round();
    uploadSpeed.value = (baseUpload + uploadVariation).clamp(10, 100);
  }

  // Toggle search bar
  void toggleSearch() {
    isSearchActive.value = !isSearchActive.value;
    if (!isSearchActive.value) {
      searchController.clear();
      searchQuery.value = '';
      _filterCountries();
    }
  }

  // Clear search
  void clearSearch() {
    searchController.clear();
    searchQuery.value = '';
    _filterCountries();
  }

  void changeBottomNavIndex(int index) {
    selectedBottomNavIndex.value = index;

    switch (index) {
      case 0:
        // Countries tab - already on home
        break;
      case 1:
        // Disconnect
        if (connectionStatus.value == ConnectionStatus.connected) {
          disconnect();
        }
        break;
      case 2:
        // Settings
        Get.toNamed('/settings'); // Bu satır güncellendi
        break;
    }
  }

  // Format connection duration
  String get formattedConnectionTime {
    final duration = connectionDuration.value;
    final hours = duration.inHours.toString().padLeft(2, '0');
    final minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$hours:$minutes:$seconds';
  }

  // Get connection status text
  String get connectionStatusText {
    switch (connectionStatus.value) {
      case ConnectionStatus.connected:
        return 'Connected';
      case ConnectionStatus.connecting:
        return 'Connecting...';
      case ConnectionStatus.disconnected:
        return 'Disconnected';
    }
  }

  // Get connection status color
  Color get connectionStatusColor {
    switch (connectionStatus.value) {
      case ConnectionStatus.connected:
        return AppColors.connected;
      case ConnectionStatus.connecting:
        return AppColors.connecting;
      case ConnectionStatus.disconnected:
        return AppColors.disconnected;
    }
  }

  // Check if country is available (not premium)
  bool isCountryAvailable(Country country) {
    // In this mock implementation, all countries are free
    // You can modify this logic based on your requirements
    return true;
  }

  // Get signal strength color
  Color getSignalStrengthColor(int strength) {
    if (strength >= 80) return AppColors.connected;
    if (strength >= 60) return AppColors.connecting;
    return AppColors.disconnected;
  }

  // Refresh countries list
  Future<void> refreshCountries() async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    // In a real app, you would fetch from API
    countries.refresh();
    _filterCountries();
  }
}
