import 'package:flutter/material.dart';
import '../core/constants/app_constants.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_text.dart';
import '../core/utils/formatters.dart';
import '../core/utils/responsive.dart';

class WantedPoster extends StatelessWidget {
  final String name;
  final int bounty;

  const WantedPoster({super.key, required this.name, required this.bounty});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.sz(4)),
      decoration: BoxDecoration(
        color: AppColors.parchment,
        borderRadius: BorderRadius.circular(context.sz(2)),
        border: Border.all(color: AppColors.ink, width: context.sz(1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black38,
            blurRadius: context.sz(4),
            offset: Offset(0, context.sz(1.5)),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'WANTED',
            textAlign: TextAlign.center,
            style: AppText.heading(context, size: 17, color: AppColors.ink),
          ),
          SizedBox(height: context.sz(2)),
          Container(
            height: context.sz(36),
            padding: EdgeInsets.all(context.sz(3)),
            decoration: BoxDecoration(
              color: AppColors.parchmentDark,
              border: Border.all(color: AppColors.ink, width: context.sz(0.8)),
            ),
            child: Image.asset(
              AppAssets.logo,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => Icon(
                Icons.directions_boat_rounded,
                size: context.sz(20),
                color: AppColors.ink,
              ),
            ),
          ),
          SizedBox(height: context.sz(2)),
          Text(
            'DEAD OR ALIVE',
            textAlign: TextAlign.center,
            style: AppText.body(
              context,
              size: 3.4,
              weight: FontWeight.w700,
              color: AppColors.ink,
            ).copyWith(letterSpacing: context.sz(0.8)),
          ),
          SizedBox(height: context.sz(1)),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              name.toUpperCase(),
              style: AppText.heading(context, size: 11, color: AppColors.ink),
            ),
          ),
          SizedBox(height: context.sz(1)),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              formatNumber(bounty),
              style: AppText.heading(context, size: 13, color: AppColors.ink),
            ),
          ),
          Text(
            'BERRY',
            textAlign: TextAlign.center,
            style: AppText.body(
              context,
              size: 3.2,
              weight: FontWeight.w700,
              color: AppColors.ink,
            ).copyWith(letterSpacing: context.sz(1)),
          ),
        ],
      ),
    );
  }
}