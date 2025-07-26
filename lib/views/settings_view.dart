import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tt_vpn_app/controllers/settings_controller.dart';
import 'package:tt_vpn_app/constants/constants.dart';
import 'package:tt_vpn_app/views/widgets/app_header.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SettingsController());

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          const AppHeader(
            title: AppStrings.settings,
            showBackButton: true,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppDimensions.paddingXL),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle(AppStrings.appearance),
                  _buildThemeSection(controller),
                  
                  const SizedBox(height: AppDimensions.paddingXL),
                  
                  _buildSectionTitle(AppStrings.vpnSettings),
                  _buildVPNSettings(controller),
                  
                  const SizedBox(height: AppDimensions.paddingXL),
                  
                  _buildSectionTitle(AppStrings.general),
                  _buildGeneralSettings(controller),
                  
                  const SizedBox(height: AppDimensions.paddingXL),
                  
                  _buildSectionTitle(AppStrings.about),
                  _buildAboutSection(controller),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppDimensions.paddingM),
      child: Text(
        title,
        style: AppTextStyles.bodyLarge.copyWith(
          fontWeight: FontWeight.w600,
          color: AppColors.primary,
        ),
      ),
    );
  }

  Widget _buildThemeSection(SettingsController controller) {
    return Card(
      color: AppColors.cardBackground,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingM),
        child: Column(
          children: [
            _buildThemeOption(
              controller,
              AppStrings.lightTheme,
              Icons.light_mode,
              false,
            ),
            const Divider(height: 1),
            _buildThemeOption(
              controller,
              AppStrings.darkTheme,
              Icons.dark_mode,
              true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeOption(
    SettingsController controller,
    String title,
    IconData icon,
    bool isDark,
  ) {
    return Obx(() {
      final isSelected = controller.themeController.isDarkMode == isDark;
      
      return InkWell(
        onTap: () => controller.themeController.setTheme(isDark),
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingM,
            vertical: AppDimensions.paddingS,
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppDimensions.paddingS),
                decoration: BoxDecoration(
                  color: isSelected 
                      ? AppColors.primary.withOpacity(0.1)
                      : AppColors.textSecondary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppDimensions.radiusS),
                ),
                child: Icon(
                  icon,
                  color: isSelected ? AppColors.primary : AppColors.textSecondary,
                  size: AppDimensions.iconM,
                ),
              ),
              const SizedBox(width: AppDimensions.paddingM),
              Expanded(
                child: Text(
                  title,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: isSelected ? AppColors.primary : AppColors.textPrimary,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  ),
                ),
              ),
              if (isSelected)
                Icon(
                  Icons.check_circle,
                  color: AppColors.primary,
                  size: AppDimensions.iconM,
                ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildVPNSettings(SettingsController controller) {
    return Card(
      color: AppColors.cardBackground,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingM),
        child: Column(
          children: [
            _buildSwitchTile(
              controller,
              AppStrings.autoConnect,
              AppStrings.autoConnectDescription,
              Icons.power_settings_new,
              controller.autoConnect,
              controller.toggleAutoConnect,
            ),
            const Divider(height: 1),
            _buildSwitchTile(
              controller,
              AppStrings.killSwitch,
              AppStrings.killSwitchDescription,
              Icons.security,
              controller.killSwitch,
              controller.toggleKillSwitch,
            ),
            const Divider(height: 1),
            _buildProtocolSelector(controller),
          ],
        ),
      ),
    );
  }

  Widget _buildGeneralSettings(SettingsController controller) {
    return Card(
      color: AppColors.cardBackground,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingM),
        child: Column(
          children: [
            _buildSwitchTile(
              controller,
              AppStrings.notifications,
              AppStrings.notificationsDescription,
              Icons.notifications,
              controller.notificationsEnabled,
              controller.toggleNotifications,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAboutSection(SettingsController controller) {
    return Card(
      color: AppColors.cardBackground,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingM),
        child: Column(
          children: [
            _buildActionTile(
              AppStrings.aboutApp,
              AppStrings.aboutAppDescription,
              Icons.info,
              () => controller.showAboutDialog(),
            ),
            const Divider(height: 1),
            _buildActionTile(
              AppStrings.clearData,
              AppStrings.clearDataShortDescription,
              Icons.delete,
              () => controller.clearAllData(),
              isDestructive: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchTile(
    SettingsController controller,
    String title,
    String description,
    IconData icon,
    RxBool value,
    Function(bool) onChanged,
  ) {
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingM,
          vertical: AppDimensions.paddingS,
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(AppDimensions.paddingS),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppDimensions.radiusS),
              ),
              child: Icon(
                icon,
                color: AppColors.primary,
                size: AppDimensions.iconM,
              ),
            ),
            const SizedBox(width: AppDimensions.paddingM),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    description,
                    style: AppTextStyles.caption,
                  ),
                ],
              ),
            ),
            Switch(
              value: value.value,
              onChanged: onChanged,
              activeColor: AppColors.primary,
            ),
          ],
        ),
      );
    });
  }

  Widget _buildProtocolSelector(SettingsController controller) {
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingM,
          vertical: AppDimensions.paddingS,
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(AppDimensions.paddingS),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppDimensions.radiusS),
              ),
              child: Icon(
                Icons.vpn_lock,
                color: AppColors.primary,
                size: AppDimensions.iconM,
              ),
            ),
            const SizedBox(width: AppDimensions.paddingM),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.protocol,
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    AppStrings.protocolDescription,
                    style: AppTextStyles.caption,
                  ),
                ],
              ),
            ),
            DropdownButton<String>(
              value: controller.selectedProtocol.value,
              onChanged: (String? newValue) {
                if (newValue != null) {
                  controller.changeProtocol(newValue);
                }
              },
              underline: const SizedBox.shrink(),
              style: AppTextStyles.bodyMedium,
              dropdownColor: AppColors.cardBackground,
              items: controller.protocols.map((String protocol) {
                return DropdownMenuItem<String>(
                  value: protocol,
                  child: Text(protocol),
                );
              }).toList(),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildActionTile(
    String title,
    String description,
    IconData icon,
    VoidCallback onTap, {
    bool isDestructive = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppDimensions.radiusM),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingM,
          vertical: AppDimensions.paddingS,
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(AppDimensions.paddingS),
              decoration: BoxDecoration(
                color: isDestructive 
                    ? AppColors.disconnected.withOpacity(0.1)
                    : AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppDimensions.radiusS),
              ),
              child: Icon(
                icon,
                color: isDestructive ? AppColors.disconnected : AppColors.primary,
                size: AppDimensions.iconM,
              ),
            ),
            const SizedBox(width: AppDimensions.paddingM),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                      color: isDestructive ? AppColors.disconnected : AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    description,
                    style: AppTextStyles.caption,
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: AppDimensions.iconS,
              color: AppColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }
}