import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tt_vpn_app/controllers/home_controller.dart';
import 'package:tt_vpn_app/constants/constants.dart';
import 'package:tt_vpn_app/models/country_model.dart';
import 'package:tt_vpn_app/views/widgets/app_header.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          AppHeader(
            title: AppStrings.countries,
            showSearchBar: true,
            searchHint: AppStrings.searchHint,
            onSearchTap: () => Get.toNamed('/country-selection'),
            leftIcon: SvgPicture.asset(
              AppAssets.iconCategory,
              width: AppDimensions.iconM,
              height: AppDimensions.iconM,
            ),
            rightIcon: SvgPicture.asset(
              AppAssets.iconCrown,
              width: AppDimensions.iconM,
              height: AppDimensions.iconM,
            ),
          ),
          const SizedBox(height: AppDimensions.paddingL),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildConnectionTimeCard(context, controller),
                  const SizedBox(height: AppDimensions.paddingL),
                  Obx(() {
                    final isConnecting =
                        controller.connectingCountryName.value.isNotEmpty;
                    final connectedCountry = controller.connectedCountry.value;
                    final connectionStatus = controller.connectionStatus.value;
                    if (isConnecting) {
                      return _buildConnectingCard(context, controller);
                    } else if (connectedCountry != null &&
                        connectionStatus == ConnectionStatus.connected) {
                      return _buildConnectedCountryCard(
                          context, controller, connectedCountry);
                    } else {
                      return _buildDisconnectedCard(context);
                    }
                  }),
                  _buildSpeedStatsCard(context, controller),
                  const SizedBox(height: AppDimensions.paddingL),
                  _buildFreeLocationsHeader(context, controller),
                  const SizedBox(height: AppDimensions.paddingS),
                  _buildCountriesList(context, controller),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context, controller),
    );
  }

  Widget _buildConnectionTimeCard(BuildContext context, HomeController controller) {
    return Column(
      children: [
        Text(
          AppStrings.connectingTime,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            color: Theme.of(context).colorScheme.onBackground.withOpacity(0.7),
          ),
        ),
        Obx(() => Text(
              controller.formattedConnectionTime,
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: Theme.of(context).colorScheme.onBackground,
              ),
            )),
      ],
    );
  }

  Widget _buildConnectedCountryCard(
      BuildContext context, HomeController controller, Country country) {
    return Card(
      color: Theme.of(context).colorScheme.surface,
      elevation: 2,
      margin: const EdgeInsets.fromLTRB(
        AppDimensions.paddingXXL,
        0,
        AppDimensions.paddingXXL,
        AppDimensions.paddingM,
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingM),
        child: Row(
          children: [
            Container(
              width: AppDimensions.flagWidth,
              height: AppDimensions.flagHeight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppDimensions.radiusS),
                image: DecorationImage(
                  image: AssetImage(country.flag),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(width: AppDimensions.paddingM),

            // Country Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    country.name,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  if (country.city != null && country.city!.isNotEmpty)
                    Text(
                      country.city!,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                      ),
                    ),
                ],
              ),
            ),

            // Signal Strength
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  AppStrings.stealth,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
                const SizedBox(width: AppDimensions.paddingS),
                Text(
                  '${country.strength}%',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDisconnectedCard(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.surface,
      elevation: 2,
      margin: const EdgeInsets.fromLTRB(
        AppDimensions.paddingXXL,
        0,
        AppDimensions.paddingXXL,
        AppDimensions.paddingM,
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingM),
        child: Row(
          children: [
            // Animated disconnected icon
            TweenAnimationBuilder<double>(
              duration: const Duration(seconds: 2),
              tween: Tween(begin: 0.0, end: 1.0),
              builder: (context, value, child) {
                return Container(
                  width: AppDimensions.flagWidth,
                  height: AppDimensions.flagHeight,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppDimensions.radiusS),
                    color: AppColors.disconnected.withOpacity(0.1),
                    border: Border.all(
                      color: AppColors.disconnected.withOpacity(0.3),
                      width: 2,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Center(
                    child: Transform.scale(
                      scale: 0.8 + (0.2 * value),
                      child: Icon(
                        Icons.wifi_off_rounded,
                        color: AppColors.disconnected
                            .withOpacity(0.7 + (0.3 * value)),
                        size: AppDimensions.iconM,
                      ),
                    ),
                  ),
                );
              },
            ),

            const SizedBox(width: AppDimensions.paddingM),

            // Disconnected text with fade animation
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TweenAnimationBuilder<double>(
                    duration: const Duration(milliseconds: 1500),
                    tween: Tween(begin: 0.0, end: 1.0),
                    builder: (context, value, child) {
                      return Opacity(
                        opacity: value,
                        child: Text(
                          "Not Connected",
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: AppColors.disconnected,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 4),
                  TweenAnimationBuilder<double>(
                    duration: const Duration(milliseconds: 2000),
                    tween: Tween(begin: 0.0, end: 1.0),
                    builder: (context, value, child) {
                      return Opacity(
                        opacity: value,
                        child: Text(
                          "Choose a location",
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            // Animated pulse dot
            TweenAnimationBuilder<double>(
              duration: const Duration(seconds: 1),
              tween: Tween(begin: 0.0, end: 1.0),
              builder: (context, value, child) {
                return Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color:
                        AppColors.disconnected.withOpacity(0.5 + (0.5 * value)),
                    shape: BoxShape.circle,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConnectingCard(BuildContext context, HomeController controller) {
    return Card(
      color: Theme.of(context).colorScheme.surface,
      elevation: 2,
      margin: const EdgeInsets.fromLTRB(
        AppDimensions.paddingXXL,
        0,
        AppDimensions.paddingXXL,
        AppDimensions.paddingM,
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingM),
        child: Row(
          children: [
            Container(
              width: AppDimensions.flagWidth,
              height: AppDimensions.flagHeight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppDimensions.radiusS),
                gradient: LinearGradient(
                  colors: [
                    AppColors.connecting.withOpacity(0.1),
                    AppColors.connecting.withOpacity(0.3),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  TweenAnimationBuilder<double>(
                    duration: const Duration(seconds: 2),
                    tween: Tween(begin: 0.0, end: 1.0),
                    builder: (context, value, child) {
                      return Transform.rotate(
                        angle: value * 2 * 3.14159,
                        child: Container(
                          width: AppDimensions.iconM,
                          height: AppDimensions.iconM,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.connecting,
                              width: 2,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  TweenAnimationBuilder<double>(
                    duration: const Duration(milliseconds: 800),
                    tween: Tween(begin: 0.5, end: 1.0),
                    builder: (context, value, child) {
                      return Container(
                        width: 8 * value,
                        height: 8 * value,
                        decoration: const BoxDecoration(
                          color: AppColors.connecting,
                          shape: BoxShape.circle,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(width: AppDimensions.paddingM),

            // Connecting text with typing animation
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Animated connecting text
                  TweenAnimationBuilder<int>(
                    duration: const Duration(milliseconds: 1500),
                    tween: IntTween(begin: 0, end: "Connecting".length),
                    builder: (context, value, child) {
                      return Text(
                        "Connecting${"." * ((value % 4))}",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColors.connecting,
                          fontWeight: FontWeight.w600,
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 4),
                  Obx(() {
                    final connectingCountry =
                        controller.connectingCountryName.value;
                    return TweenAnimationBuilder<double>(
                      duration: const Duration(milliseconds: 500),
                      tween: Tween(begin: 0.0, end: 1.0),
                      builder: (context, value, child) {
                        return Opacity(
                          opacity: value,
                          child: Text(
                            connectingCountry.isNotEmpty
                                ? "to $connectingCountry"
                                : "Please wait",
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                            ),
                          ),
                        );
                      },
                    );
                  }),
                ],
              ),
            ),

            // Animated signal waves
            Column(
              children: List.generate(3, (index) {
                return TweenAnimationBuilder<double>(
                  duration: Duration(milliseconds: 600 + (index * 200)),
                  tween: Tween(begin: 0.0, end: 1.0),
                  builder: (context, value, child) {
                    return Container(
                      width: 4,
                      height: 8 + (index * 4) * value,
                      margin: const EdgeInsets.symmetric(vertical: 1),
                      decoration: BoxDecoration(
                        color: AppColors.connecting
                            .withOpacity(0.3 + (0.7 * value)),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpeedStatsCard(BuildContext context, HomeController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Card(
            color: Theme.of(context).colorScheme.surface,
            elevation: 2,
            margin: const EdgeInsets.fromLTRB(
              AppDimensions.paddingXXL,
              0,
              AppDimensions.paddingXS,
              AppDimensions.paddingM,
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppDimensions.paddingM),
              child: _buildSpeedItem(
                context,
                controller,
                AppAssets.iconImport,
                AppStrings.download,
                () => controller.downloadSpeed.value,
                AppColors.connected,
              ),
            ),
          ),
        ),
        Expanded(
          child: Card(
            color: Theme.of(context).colorScheme.surface,
            elevation: 2,
            margin: const EdgeInsets.fromLTRB(
              AppDimensions.paddingXS,
              0,
              AppDimensions.paddingXXL,
              AppDimensions.paddingM,
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppDimensions.paddingM),
              child: _buildSpeedItem(
                context,
                controller,
                AppAssets.iconExport,
                AppStrings.upload,
                () => controller.uploadSpeed.value,
                AppColors.disconnected,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSpeedItem(
    BuildContext context,
    HomeController controller,
    String iconPath,
    String label,
    int Function() speedGetter,
    Color color,
  ) {
    return Row(
      children: [
        Container(
          height: AppDimensions.iconL,
          width: AppDimensions.iconL,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: color.withOpacity(0.15),
          ),
          alignment: Alignment.center,
          child: SvgPicture.asset(
            iconPath,
            width: AppDimensions.iconM,
            height: AppDimensions.iconM,
          ),
        ),
        const SizedBox(width: AppDimensions.paddingS),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
            Obx(() => Text(
                  '${speedGetter()} ${AppStrings.mbUnit}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                )),
          ],
        ),
      ],
    );
  }

  Widget _buildFreeLocationsHeader(BuildContext context, HomeController controller) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppDimensions.paddingXL,
        0,
        AppDimensions.paddingXL,
        0,
      ),
      child: Row(
        children: [
          Text(
            '${AppStrings.freeLocations} (${controller.countries.length})',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
          const Spacer(),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(AppDimensions.radiusS),
            ),
            child: Icon(
              Icons.info,
              size: AppDimensions.iconS,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCountriesList(BuildContext context, HomeController controller) {
    return Obx(() {
      final filteredCountries = controller.filteredCountries;
      return ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: filteredCountries.length,
        itemBuilder: (context, index) {
          final country = filteredCountries[index];
          return _buildCountryCard(context, controller, country);
        },
      );
    });
  }

  Widget _buildCountryCard(BuildContext context, HomeController controller, Country country) {
    return Card(
      color: Theme.of(context).colorScheme.surface,
      elevation: 2,
      margin: const EdgeInsets.fromLTRB(
        AppDimensions.paddingXL,
        0,
        AppDimensions.paddingXL,
        AppDimensions.paddingM,
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingM),
        child: Row(
          children: [
            Container(
              width: AppDimensions.flagWidth,
              height: AppDimensions.flagHeight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppDimensions.radiusS),
                image: DecorationImage(
                  image: AssetImage(country.flag),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(width: AppDimensions.paddingM),

            // Country Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    country.name,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  Text(
                    '${country.locationCount} ${AppStrings.locations}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),

            // Connection Button
            _buildConnectionButton(context, controller, country),
            const SizedBox(width: AppDimensions.paddingS),
            _buildArrowButton(context),
          ],
        ),
      ),
    );
  }

  Container _buildArrowButton(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.06),
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
      ),
      alignment: Alignment.center,
      child: Center(
        child: SizedBox(
          width: AppDimensions.iconS,
          height: AppDimensions.iconS,
          child: SvgPicture.asset(
            "assets/icons/arrow-right.svg",
            colorFilter: ColorFilter.mode(
              Theme.of(context).colorScheme.onSurface,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildConnectionButton(BuildContext context, HomeController controller, Country country) {
    return Obx(() {
      final isConnected = country.isConnected;
      final isConnecting =
          controller.connectingCountryName.value == country.name;

      if (isConnecting) {
        return Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.connecting,
            borderRadius: BorderRadius.circular(AppDimensions.radiusL),
          ),
          alignment: Alignment.center,
          child: const Center(
            child: SizedBox(
              width: AppDimensions.iconS,
              height: AppDimensions.iconS,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
              ),
            ),
          ),
        );
      }

      return GestureDetector(
        onTap: () {
          if (isConnected) {
            controller.disconnect();
          } else {
            controller.connectToCountry(country);
          }
        },
        child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: isConnected
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.onSurface.withOpacity(0.06),
              borderRadius: BorderRadius.circular(AppDimensions.radiusL),
            ),
            alignment: Alignment.center,
            child: SvgPicture.asset(
              "assets/icons/timer.svg",
              color: isConnected ? AppColors.white : Theme.of(context).colorScheme.onSurface,
              width: AppDimensions.iconM,
              height: AppDimensions.iconM,
            )),
      );
    });
  }

  Widget _buildBottomNavigationBar(BuildContext context, HomeController controller) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.1),
            blurRadius: AppDimensions.elevationM,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingS,
            vertical: AppDimensions.paddingXS,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildBottomNavItem(
                context,
                controller,
                0,
                AppAssets.iconMap,
                AppStrings.countries,
              ),
              _buildBottomNavItem(
                context,
                controller,
                1,
                AppAssets.iconRadar,
                AppStrings.disconnect,
              ),
              _buildBottomNavItem(
                context,
                controller,
                2,
                AppAssets.iconSetting,
                AppStrings.settings,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavItem(
    BuildContext context,
    HomeController controller,
    int index,
    String iconPath,
    String label,
  ) {
    return Obx(() {
      final selectedIndex = controller.selectedBottomNavIndex.value;
      final isSelected = selectedIndex == index;
      return GestureDetector(
        onTap: () => controller.changeBottomNavIndex(index),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingM,
            vertical: AppDimensions.paddingS,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                iconPath,
                width: AppDimensions.iconNavBar,
                height: AppDimensions.iconNavBar,
                colorFilter: ColorFilter.mode(
                  isSelected ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(height: AppDimensions.paddingXS),
              Text(
                label,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: isSelected ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}