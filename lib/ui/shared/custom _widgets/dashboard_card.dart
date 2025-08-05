import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:task_P2/ui/shared/colors.dart';
import 'package:task_P2/ui/shared/custom%20_widgets/custom_rounded_container.dart';
import 'package:task_P2/ui/shared/shared_widgets/section_heading.dart';
import 'package:task_P2/ui/shared/size.dart';
import 'package:task_P2/ui/shared/utlis.dart';

class TDashboardCard extends StatelessWidget {
  const TDashboardCard(
      {super.key,
      required this.title,
      required this.subTitle,
      this.icon = Iconsax.arrow_up_3,
      this.color = AppColors.success,
      required this.stats,
      this.onTap});

  final String title, subTitle;
  final IconData icon;
  final Color color;
  final int stats;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      backgroundColor: AppColors.secondcolor,
      onTap: onTap,
      padding: const EdgeInsets.all(TSize.lg),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: screenWidth(70),
              ),
              Icon(
                icon,
                color: AppColors.primary,
                size: screenWidth(14),
              ),
            ],
          ),
          const SizedBox(
            height: TSize.spaceBtwItems,
          ),
          TSectionHeading(
            title: title,
            textColor: AppColors.primary,
          ),
          const SizedBox(
            height: TSize.spaceBtwItems,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(subTitle,
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: screenWidth(22),
                    fontWeight: FontWeight.bold,
                  )),
            ],
          )
        ],
      ),
    );
  }
}
