import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tt_vpn_app/constants/app_constants.dart';
import 'package:tt_vpn_app/controllers/theme_controllers.dart';

class SettingsController extends GetxController {
  final _storage = GetStorage();

  // Reactive variables
  final RxBool notificationsEnabled = true.obs;
  final RxBool autoConnect = false.obs;
  final RxBool killSwitch = true.obs;
  final RxString selectedProtocol = 'OpenVPN'.obs;
  final RxString appVersion = '1.0.0'.obs;

  // Protocol options
  final List<String> protocols = ['OpenVPN', 'IKEv2', 'WireGuard'];

  @override
  void onInit() {
    super.onInit();
    _loadSettings();
  }

  // Load settings from storage
  void _loadSettings() {
    notificationsEnabled.value = _storage.read('notifications') ?? true;
    autoConnect.value = _storage.read('auto_connect') ?? false;
    killSwitch.value = _storage.read('kill_switch') ?? true;
    selectedProtocol.value = _storage.read('protocol') ?? 'OpenVPN';
  }

  // Toggle notifications
  void toggleNotifications(bool value) {
    notificationsEnabled.value = value;
    _storage.write('notifications', value);
  }

  // Toggle auto connect
  void toggleAutoConnect(bool value) {
    autoConnect.value = value;
    _storage.write('auto_connect', value);
  }

  // Toggle kill switch
  void toggleKillSwitch(bool value) {
    killSwitch.value = value;
    _storage.write('kill_switch', value);
  }

  // Change protocol
  void changeProtocol(String protocol) {
    selectedProtocol.value = protocol;
    _storage.write('protocol', protocol);
  }

  // Get theme controller
  ThemeController get themeController => Get.find<ThemeController>();

  // Go back
  void goBack() {
    Get.back();
  }

  // Show about dialog
  void showAboutDialog() {
    Get.dialog(
      AlertDialog(
        backgroundColor: Theme.of(Get.context!).colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        ),
        title: Text(
          AppStrings.aboutApp,
          style: Theme.of(Get.context!).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'TT VPN App',
              style: Theme.of(Get.context!).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: AppDimensions.paddingS),
            Text(
              'Version: ${appVersion.value}',
              style: Theme.of(Get.context!).textTheme.bodyMedium,
            ),
            const SizedBox(height: AppDimensions.paddingM),
            Text(
              AppStrings.aboutDescription,
              style: Theme.of(Get.context!).textTheme.bodyMedium,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              AppStrings.close,
              style: Theme.of(Get.context!).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(Get.context!).colorScheme.primary,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  // Clear all data
  void clearAllData() {
    Get.dialog(
      AlertDialog(
        backgroundColor: Theme.of(Get.context!).colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        ),
        title: Text(
          AppStrings.clearData,
          style: Theme.of(Get.context!).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        content: Text(
          AppStrings.clearDataDescription,
          style: Theme.of(Get.context!).textTheme.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              AppStrings.cancel,
              style: Theme.of(Get.context!).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(Get.context!)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.7),
                  ),
            ),
          ),
          TextButton(
            onPressed: () {
              _storage.erase();
              Get.back();
              Get.snackbar(
                AppStrings.success,
                AppStrings.dataCleared,
                backgroundColor: AppColors.connected,
                colorText: AppColors.white,
                borderRadius: AppDimensions.radiusM,
                margin: const EdgeInsets.all(AppDimensions.paddingM),
              );
            },
            child: Text(
              AppStrings.clear,
              style: Theme.of(Get.context!).textTheme.bodyMedium?.copyWith(
                    color: AppColors.disconnected,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
