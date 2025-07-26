import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tt_vpn_app/controllers/country_controller.dart';
import 'package:tt_vpn_app/constants/constants.dart';
import 'package:tt_vpn_app/models/country_model.dart';
import 'package:tt_vpn_app/views/widgets/app_header.dart';

class CountrySelectionView extends StatelessWidget {
  const CountrySelectionView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CountrySelectionController());

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          AppHeader(
            title: AppStrings.selectCountry,
            showBackButton: true,
            showSearchBar: true,
            searchController: controller.searchController,
            searchHint: AppStrings.searchHint,
          ),
          const SizedBox(
            height: AppDimensions.paddingXL,
          ),
          Expanded(
            child: _buildCountriesListSection(controller),
          ),
        ],
      ),
    );
  }

  Widget _buildCountriesListSection(CountrySelectionController controller) {
    return Obx(() {
      if (controller.isLoading.value) {
        return Center(
          child: CircularProgressIndicator(
            color: AppColors.primary,
          ),
        );
      }

      final filteredCountries = controller.filteredCountries;

      if (filteredCountries.isEmpty) {
        return const SizedBox.shrink();
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Results header
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppDimensions.paddingXL,
              0,
              AppDimensions.paddingXL,
              AppDimensions.paddingS,
            ),
            child: Text(
              '${AppStrings.availableCountries} (${filteredCountries.length})',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.medium,
              ),
            ),
          ),

          // Countries list
          Expanded(
            child: RefreshIndicator(
              onRefresh: () => controller.refreshCountries(),
              color: AppColors.primary,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.paddingXL,
                ),
                itemCount: filteredCountries.length,
                itemBuilder: (context, index) {
                  final country = filteredCountries[index];
                  return _buildCountryCard(controller, country);
                },
              ),
            ),
          ),
        ],
      );
    });
  }

  Widget _buildCountryCard(
      CountrySelectionController controller, Country country) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
      ),
      color: AppColors.white,
      elevation: 2,
      margin: const EdgeInsets.only(bottom: AppDimensions.paddingM),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        onTap: () => controller.selectCountry(country),
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.paddingM),
          child: Row(
            children: [
              // Flag
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
                      style: AppTextStyles.countryName,
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Text(
                          '${country.locationCount} ${AppStrings.locations}',
                          style: AppTextStyles.caption,
                        ),
                        if (country.city != null &&
                            country.city!.isNotEmpty) ...[
                          Text(
                            ' • ',
                            style: AppTextStyles.caption,
                          ),
                          Text(
                            country.city!,
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),

              // Signal Strength
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDimensions.paddingS,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: _getSignalColor(country.strength).withOpacity(0.1),
                      borderRadius:
                          BorderRadius.circular(AppDimensions.radiusS),
                    ),
                    child: Text(
                      '${country.strength}%',
                      style: AppTextStyles.caption.copyWith(
                        color: _getSignalColor(country.strength),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  _buildSignalBars(country.strength),
                ],
              ),

              const SizedBox(width: AppDimensions.paddingS),

              // Arrow
              const Icon(
                Icons.arrow_forward_ios_rounded,
                size: AppDimensions.iconS,
                color: AppColors.light,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSignalBars(int strength) {
    return Row(
      children: List.generate(4, (index) {
        final isActive = (strength / 25) > index;
        return Container(
          width: 3,
          height: 8 + (index * 2),
          margin: const EdgeInsets.only(right: 2),
          decoration: BoxDecoration(
            color: isActive ? _getSignalColor(strength) : AppColors.light,
            borderRadius: BorderRadius.circular(1),
          ),
        );
      }),
    );
  }

  Color _getSignalColor(int strength) {
    if (strength >= 80) return AppColors.connected;
    if (strength >= 60) return AppColors.connecting;
    return AppColors.disconnected;
  }
}
