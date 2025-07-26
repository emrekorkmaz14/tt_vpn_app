import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tt_vpn_app/constants/constants.dart';

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
        image: DecorationImage(
          image: AssetImage("assets/images/headerBg.png"),
          fit: BoxFit.cover,
        ),
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
                      style: AppTextStyles.h3.copyWith(color: AppColors.white),
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
      return const SizedBox.shrink();
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
      return const SizedBox.shrink();
    }
  }

  Widget _buildSearchBar() {
    if (searchController != null) {
      return Container(
        height: AppDimensions.searchBarHeight,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        ),
        alignment: Alignment.center,
        child: TextField(
          controller: searchController,
          style: AppTextStyles.bodyLarge,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            hintText: searchHint ?? AppStrings.searchHint,
            hintStyle: AppTextStyles.searchHint,
            suffixIcon: Padding(
              padding: const EdgeInsets.all(AppDimensions.paddingM),
              child: SvgPicture.asset(
                AppAssets.iconSearch,
                colorFilter: ColorFilter.mode(
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
                    style: AppTextStyles.searchHint,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(AppDimensions.paddingXS),
                  child: SvgPicture.asset(
                    AppAssets.iconSearch,
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
