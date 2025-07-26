import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:tt_vpn_app/controllers/home_controller.dart';
import 'package:tt_vpn_app/models/country_model.dart';
import 'package:tt_vpn_app/data/mockdata.dart';

class CountrySelectionController extends GetxController {
  // Reactive variables
  final RxList<Country> countries = <Country>[].obs;
  final RxList<Country> filteredCountries = <Country>[].obs;
  final RxString searchQuery = ''.obs;
  final RxBool isLoading = false.obs;

  // Controllers
  final TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    _initializeData();
    _setupSearchListener();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  // Initialize data
  void _initializeData() {
    isLoading.value = true;

    // Simulate loading
    Future.delayed(const Duration(milliseconds: 500), () {
      countries.addAll(mockCountries);
      filteredCountries.addAll(mockCountries);
      isLoading.value = false;
    });
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

  // Select country and return to home
  void selectCountry(Country country) {
    // Home controller'a bilgi gönder
    if (Get.isRegistered<HomeController>()) {
      final homeController = Get.find<HomeController>();
      homeController.connectToCountry(country);
    }

    // Ana sayfaya geri dön
    Get.back();
  }

  // Clear search
  void clearSearch() {
    searchController.clear();
    searchQuery.value = '';
    _filterCountries();
  }

  // Go back
  void goBack() {
    Get.back();
  }

  // Refresh countries
  Future<void> refreshCountries() async {
    isLoading.value = true;

    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    // Refresh data
    countries.refresh();
    _filterCountries();
    isLoading.value = false;
  }
}
