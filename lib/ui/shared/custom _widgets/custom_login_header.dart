import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_P2/core/translation/app_translation.dart';
import 'package:task_P2/ui/shared/size.dart';
import 'package:task_P2/ui/shared/text_strings.dart';

import '../image_strings.dart';

class TLoginHeader extends StatelessWidget {
  const TLoginHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          const Image(
            width: 100,
            height: 100,
            image: AssetImage(TImage.LightAppLLogo),
          ),
          const SizedBox(
            height: TSize.spaceBtwSections,
          ),
          Text(tr("تسجيل الدخول"),
              style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: TSize.sm),
          Text(
            tr("اهلاً بك في تطبيق الجمعية السورية للتنمية الاجتماعية"),
            style: Theme.of(context).textTheme.bodyMedium,
          )
        ],
      ),
    );
  }
}