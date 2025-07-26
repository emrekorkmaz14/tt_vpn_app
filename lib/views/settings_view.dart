import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tt_vpn_app/controllers/settings_controller.dart';
import 'package:tt_vpn_app/controllers/theme_controllers.dart';
import 'package:tt_vpn_app/constants/constants.dart';
import 'package:tt_vpn_app/views/widgets/app_header.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SettingsController());
    final themeController = Get.find<ThemeController>();

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
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
                  _buildSectionTitle(context, AppStrings.appearance),
                  _buildThemeSection(context, themeController),
                  
                  const SizedBox(height: AppDimensions.paddingXL),
                  
                  _buildSectionTitle(context, AppStrings.vpnSettings),
                  _buildVPNSettings(context, controller),
                  
                  const SizedBox(height: AppDimensions.paddingXL),
                  
                  _buildSectionTitle(context, AppStrings.general),
                  _buildGeneralSettings(context, controller),
                  
                  const SizedBox(height: AppDimensions.paddingXL),
                  
                  _buildSectionTitle(context, AppStrings.about),
                  _buildAboutSection(context, controller),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppDimensions.paddingM),
      child: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.w600,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }

  Widget _buildThemeSection(BuildContext context, ThemeController themeController) {
    return Card(
      color: Theme.of(context).colorScheme.surface,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingM),
        child: Column(
          children: [
            _buildThemeOption(
              context,
              themeController,
              AppStrings.lightTheme,
              Icons.light_mode,
              ThemeMode.light,
            ),
            const Divider(height: 1),
            _buildThemeOption(
              context,
              themeController,
              AppStrings.darkTheme,
              Icons.dark_mode,
              ThemeMode.dark,
            ),
            const Divider(height: 1),
            _buildThemeOption(
              context,
              themeController,
              AppStrings.systemTheme,
              Icons.brightness_auto,
              ThemeMode.system,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeOption(
    BuildContext context,
    ThemeController themeController,
    String title,
    IconData icon,
    ThemeMode mode,
  ) {
    return Obx(() {
      final isSelected = themeController.themeMode == mode;
      
      return InkWell(
        onTap: () => themeController.setThemeMode(mode),
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
                      ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
                      : Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppDimensions.radiusS),
                ),
                child: Icon(
                  icon,
                  color: isSelected ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.onSurface,
                  size: AppDimensions.iconM,
                ),
              ),
              const SizedBox(width: AppDimensions.paddingM),
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: isSelected ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.onSurface,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  ),
                ),
              ),
              if (isSelected)
                Icon(
                  Icons.check_circle,
                  color: Theme.of(context).colorScheme.primary,
                  size: AppDimensions.iconM,
                ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildVPNSettings(BuildContext context, SettingsController controller) {
    return Card(
      color: Theme.of(context).colorScheme.surface,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingM),
        child: Column(
          children: [
            _buildSwitchTile(
              context,
              controller,
              AppStrings.autoConnect,
              AppStrings.autoConnectDescription,
              Icons.power_settings_new,
              controller.autoConnect,
              controller.toggleAutoConnect,
            ),
            const Divider(height: 1),
            _buildSwitchTile(
              context,
              controller,
              AppStrings.killSwitch,
              AppStrings.killSwitchDescription,
              Icons.security,
              controller.killSwitch,
              controller.toggleKillSwitch,
            ),
            const Divider(height: 1),
            _buildProtocolSelector(context, controller),
          ],
        ),
      ),
    );
  }

  Widget _buildGeneralSettings(BuildContext context, SettingsController controller) {
    return Card(
      color: Theme.of(context).colorScheme.surface,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingM),
        child: Column(
          children: [
            _buildSwitchTile(
              context,
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

  Widget _buildAboutSection(BuildContext context, SettingsController controller) {
    return Card(
      color: Theme.of(context).colorScheme.surface,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingM),
        child: Column(
          children: [
            _buildActionTile(
              context,
              AppStrings.aboutApp,
              AppStrings.aboutAppDescription,
              Icons.info,
              () => controller.showAboutDialog(),
            ),
            const Divider(height: 1),
            _buildActionTile(
              context,
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
    BuildContext context,
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
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppDimensions.radiusS),
              ),
              child: Icon(
                icon,
                color: Theme.of(context).colorScheme.primary,
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
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            Switch(
              value: value.value,
              onChanged: onChanged,
              activeColor: Theme.of(context).colorScheme.primary,
            ),
          ],
        ),
      );
    });
  }

  Widget _buildProtocolSelector(BuildContext context, SettingsController controller) {
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
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppDimensions.radiusS),
              ),
              child: Icon(
                Icons.vpn_lock,
                color: Theme.of(context).colorScheme.primary,
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
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    AppStrings.protocolDescription,
                    style: Theme.of(context).textTheme.bodySmall,
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
              style: Theme.of(context).textTheme.bodyMedium,
              dropdownColor: Theme.of(context).colorScheme.surface,
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
    BuildContext context,
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
                    : Theme.of(context).colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppDimensions.radiusS),
              ),
              child: Icon(
                icon,
                color: isDestructive ? AppColors.disconnected : Theme.of(context).colorScheme.primary,
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
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: isDestructive ? AppColors.disconnected : Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: AppDimensions.iconS,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            ),
          ],
        ),
      ),
    );
  }
}