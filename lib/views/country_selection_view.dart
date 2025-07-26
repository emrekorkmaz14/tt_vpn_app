import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tt_vpn_app/controllers/country_controller.dart';
import 'package:tt_vpn_app/constants/app_constants.dart';
import 'package:tt_vpn_app/models/country_model.dart';
import 'package:tt_vpn_app/views/widgets/app_header.dart';

class CountrySelectionView extends StatelessWidget {
  const CountrySelectionView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CountrySelectionController());

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
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
            child: _buildCountriesListSection(context, controller),
          ),
        ],
      ),
    );
  }

  Widget _buildCountriesListSection(
      BuildContext context, CountrySelectionController controller) {
    return Obx(() {
      if (controller.isLoading.value) {
        return Center(
          child: CircularProgressIndicator(
            color: Theme.of(context).colorScheme.primary,
          ),
        );
      }

      final filteredCountries = controller.filteredCountries;

      if (filteredCountries.isEmpty) {
        return _buildEmptyState(context, controller);
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
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onBackground
                        .withOpacity(0.7),
                  ),
            ),
          ),

          // Countries list
          Expanded(
            child: RefreshIndicator(
              onRefresh: () => controller.refreshCountries(),
              color: Theme.of(context).colorScheme.primary,
              backgroundColor: Theme.of(context).colorScheme.surface,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.paddingXL,
                ),
                itemCount: filteredCountries.length,
                itemBuilder: (context, index) {
                  final country = filteredCountries[index];
                  return _buildCountryCard(context, controller, country);
                },
              ),
            ),
          ),
        ],
      );
    });
  }

  Widget _buildEmptyState(
      BuildContext context, CountrySelectionController controller) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingXL),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.search_off_rounded,
                size: 40,
                color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
              ),
            ),
            const SizedBox(height: AppDimensions.paddingL),
            Text(
              AppStrings.noCountriesFound,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppDimensions.paddingS),
            Text(
              AppStrings.tryDifferentSearch,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onBackground
                        .withOpacity(0.7),
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppDimensions.paddingL),
            ElevatedButton(
              onPressed: () => controller.clearSearch(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.paddingL,
                  vertical: AppDimensions.paddingM,
                ),
              ),
              child: Text(
                AppStrings.clearSearch,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCountryCard(BuildContext context,
      CountrySelectionController controller, Country country) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
      ),
      color: Theme.of(context).colorScheme.surface,
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
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Text(
                          '${country.locationCount} ${AppStrings.locations}',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withOpacity(0.7),
                                  ),
                        ),
                        if (country.city != null &&
                            country.city!.isNotEmpty) ...[
                          Text(
                            ' • ',
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface
                                          .withOpacity(0.7),
                                    ),
                          ),
                          Text(
                            country.city!,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
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
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
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
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: AppDimensions.iconS,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
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
