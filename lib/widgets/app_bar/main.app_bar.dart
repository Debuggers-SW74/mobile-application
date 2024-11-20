import 'package:fastporte/common/constants/app.constraints.constant.dart';
import 'package:flutter/material.dart';
import 'package:fastporte/common/constants/app.colors.constant.dart';
import 'package:fastporte/common/constants/app.text_styles.constant.dart';
import 'package:go_router/go_router.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool backLeading;

  const MainAppBar({super.key, this.backLeading = false});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Container(
        margin: EdgeInsets.only(right: (backLeading ? 60 : 0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/fastporte-logo.png',
              height: 40,
            ),
            const SizedBox(width: 10),
            Text(
              'FastPorte',
              style: AppTextStyles.headlineMedium(context).copyWith(
                color: AppColors.onPrimary,
              ),
            ),
          ],
        ),
      ),
      leading: backLeading
          ? IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                size: AppConstrainsts.iconSizeMedium,
              ),
              color: AppColors.onPrimary,
              onPressed: () {
                GoRouter.of(context).pop();
              },
            )
          : null,
      backgroundColor: AppColors.primary,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
