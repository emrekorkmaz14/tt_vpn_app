import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tt_vpn_app/constants/app_constants.dart';

class AppHeader extends StatelessWidget {
  final String title;
  final bool showBackButton;
  final bool showSearchBar;
  final VoidCallback? onSearchTap;
  final TextEditingController? searchController;
  final String? searchHint;
  final Widget? leftIcon;
  final Widget? rightIcon;

  const AppHeader({
    super.key,
    required this.title,
    this.showBackButton = false,
    this.showSearchBar = false,
    this.onSearchTap,
    this.searchController,
    this.searchHint,
    this.leftIcon,
    this.rightIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.primaryLight,
        image: DecorationImage(
            image: AssetImage("assets/images/headerBg.png"), fit: BoxFit.cover),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(36),
          bottomRight: Radius.circular(36),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            top: AppDimensions.paddingS,
            bottom: AppDimensions.paddingXL,
            left: AppDimensions.paddingXL,
            right: AppDimensions.paddingXL,
          ),
          child: Column(
            children: [
              // Top section with icons and title
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Left side
                  _buildLeftWidget(),
                  // Title
                  Expanded(
                    child: Text(
                      title,
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                color: AppColors.white,
                                fontWeight: FontWeight.w600,
                              ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  // Right side
                  _buildRightWidget(),
                ],
              ),

              // Search bar (if enabled)
              if (showSearchBar) ...[
                const SizedBox(height: AppDimensions.paddingXL),
                _buildSearchBar(),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLeftWidget() {
    if (showBackButton) {
      return GestureDetector(
        onTap: () => Get.back(),
        child: Container(
          padding: const EdgeInsets.all(AppDimensions.paddingS),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          ),
          child: const Icon(
            Icons.arrow_back_ios_rounded,
            color: AppColors.white,
            size: AppDimensions.iconM,
          ),
        ),
      );
    } else if (leftIcon != null) {
      return Container(
        padding: const EdgeInsets.all(AppDimensions.paddingS),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        ),
        child: leftIcon!,
      );
    } else {
      return const SizedBox(width: 48); // Placeholder for symmetry
    }
  }

  Widget _buildRightWidget() {
    if (rightIcon != null) {
      return Container(
        padding: const EdgeInsets.all(AppDimensions.paddingS),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        ),
        child: rightIcon!,
      );
    } else {
      return const SizedBox(width: 48); // Placeholder for symmetry
    }
  }

  Widget _buildSearchBar() {
    if (searchController != null) {
      return Container(
        height: AppDimensions.searchBarHeight,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: TextField(
          controller: searchController,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.textPrimaryLight,
            fontFamily: 'Gilroy',
          ),
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            hintText: searchHint ?? AppStrings.searchHint,
            hintStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: AppColors.textHintLight,
              fontFamily: 'Gilroy',
            ),
            suffixIcon: Padding(
              padding: const EdgeInsets.all(AppDimensions.paddingM),
              child: SvgPicture.asset(
                AppAssets.iconSearch,
                colorFilter: const ColorFilter.mode(
                  AppColors.medium,
                  BlendMode.srcIn,
                ),
              ),
            ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingM,
              vertical: 0,
            ),
            isDense: true,
          ),
        ),
      );
    } else {
      return GestureDetector(
        onTap: onSearchTap,
        child: Container(
          height: AppDimensions.searchBarHeight,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(AppDimensions.radiusM),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingM,
              vertical: AppDimensions.paddingS,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    searchHint ?? AppStrings.searchHint,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textHintLight,
                      fontFamily: 'Gilroy',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(AppDimensions.paddingXS),
                  child: SvgPicture.asset(
                    AppAssets.iconSearch,
                    colorFilter: const ColorFilter.mode(
                      AppColors.medium,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
