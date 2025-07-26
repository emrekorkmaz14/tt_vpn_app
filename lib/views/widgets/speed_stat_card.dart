import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tt_vpn_app/constants/app_constants.dart';

class SpeedStatCard extends StatelessWidget {
  final String iconPath;
  final String label;
  final int value;
  final String unit;
  final Color color;

  const SpeedStatCard({
    super.key,
    required this.iconPath,
    required this.label,
    required this.value,
    required this.unit,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.surface,
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingM),
        child: Row(
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
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.7),
                      ),
                ),
                Text(
                  '$value $unit',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
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
}
