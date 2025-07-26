import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tt_vpn_app/constants/app_constants.dart';
import 'package:tt_vpn_app/models/country_model.dart';

class CountryCard extends StatelessWidget {
  final Country country;
  final VoidCallback? onTap;
  final VoidCallback? onConnectTap;
  final bool showConnectionButton;
  final bool isConnected;
  final bool isConnecting;
  final bool showArrow;
  final bool showLocationsCount;

  const CountryCard({
    super.key,
    required this.country,
    this.onTap,
    this.onConnectTap,
    this.showConnectionButton = true,
    this.isConnected = false,
    this.isConnecting = false,
    this.showArrow = true,
    this.showLocationsCount = true,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.surface,
      elevation: 2,
      margin: const EdgeInsets.only(bottom: AppDimensions.paddingM),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.paddingM),
          child: Row(
            children: [
              // Flag
              _buildFlag(),
              const SizedBox(width: AppDimensions.paddingM),
              
              // Country Info
              Expanded(child: _buildCountryInfo(context)),
              
              // Signal Strength (if needed)
              if (!showConnectionButton) _buildSignalStrength(context),
              
              // Connection Button
              if (showConnectionButton) ...[
                _buildConnectionButton(context),
                const SizedBox(width: AppDimensions.paddingS),
              ],
              
              // Arrow
              if (showArrow) _buildArrow(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFlag() {
    return Container(
      width: AppDimensions.flagWidth,
      height: AppDimensions.flagHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppDimensions.radiusS),
        image: DecorationImage(
          image: AssetImage(country.flag),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildCountryInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          country.name,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        if (showLocationsCount)
          Text(
            '${country.locationCount} ${AppStrings.locations}',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
        if (country.city != null && country.city!.isNotEmpty)
          Text(
            country.city!,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
      ],
    );
  }

  Widget _buildSignalStrength(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingS,
            vertical: 2,
          ),
          decoration: BoxDecoration(
            color: _getSignalColor().withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppDimensions.radiusS),
          ),
          child: Text(
            '${country.strength}%',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: _getSignalColor(),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 4),
        _buildSignalBars(),
      ],
    );
  }

  Widget _buildSignalBars() {
    return Row(
      children: List.generate(4, (index) {
        final isActive = (country.strength / 25) > index;
        return Container(
          width: 3,
          height: 8 + (index * 2),
          margin: const EdgeInsets.only(right: 2),
          decoration: BoxDecoration(
            color: isActive ? _getSignalColor() : AppColors.light,
            borderRadius: BorderRadius.circular(1),
          ),
        );
      }),
    );
  }

  Widget _buildConnectionButton(BuildContext context) {
    if (isConnecting) {
      return Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.connecting,
          borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        ),
        alignment: Alignment.center,
        child: const SizedBox(
          width: 16, // AppDimensions.iconS yerine sabit değer
          height: 16,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: isConnecting ? null : onConnectTap, // isConnecting durumunda onTap'i disable et
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
          color: isConnected
              ? AppColors.white
              : Theme.of(context).colorScheme.onSurface,
          width: AppDimensions.iconM,
          height: AppDimensions.iconM,
        ),
      ),
    );
  }

  Widget _buildArrow(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.06),
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
      ),
      alignment: Alignment.center,
      child: SvgPicture.asset(
        "assets/icons/arrow-right.svg",
        colorFilter: ColorFilter.mode(
          Theme.of(context).colorScheme.onSurface,
          BlendMode.srcIn,
        ),
        width: AppDimensions.iconS,
        height: AppDimensions.iconS,
      ),
    );
  }

  Color _getSignalColor() {
    if (country.strength >= 80) return AppColors.connected;
    if (country.strength >= 60) return AppColors.connecting;
    return AppColors.disconnected;
  }
}