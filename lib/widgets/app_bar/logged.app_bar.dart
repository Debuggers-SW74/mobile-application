import 'package:fastporte/common/constants/app.constraints.constant.dart';
import 'package:fastporte/common/constants/app.routes.constant.dart';
import 'package:fastporte/providers/driver_info.provider.dart';
import 'package:fastporte/util/debug/print_navigation_stack.dart';
import 'package:flutter/material.dart';
import 'package:fastporte/common/constants/app.colors.constant.dart';
import 'package:fastporte/common/constants/app.text_styles.constant.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LoggedAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool backLeading;
  final BuildContext? ctx;

  const LoggedAppBar({super.key, required this.title, this.backLeading = false, this.ctx});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/fastporte-logo.png',
            height: 30,
          ),
          const SizedBox(width: 10),
          InkWell(
            onTap: () => printNavigationStack(ctx ?? context),
            child: Text(
              title,
              style: AppTextStyles.titleMedium(context).copyWith(
                color: AppColors.onPrimary,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: AppColors.primary,
      leading: backLeading
          ? IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                size: AppConstrainsts.iconSizeMedium,
              ),
              color: AppColors.onPrimary,
              onPressed: () {
                context.pop();
              },
            )
          : null,
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 16),
          child: ClipOval(
            child: Material(
              color: AppColors.onPrimary,
              child: PopupMenuButton<int>(
                onSelected: (item) => onSelected(context, item),
                offset: const Offset(0, 5),
                position: PopupMenuPosition.under,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                itemBuilder: (context) => [
                  PopupMenuItem<int>(
                    value: 0,
                    height: 15.0,
                    child: ListTile(
                      minTileHeight: 15.0,
                      minVerticalPadding: 10.0,
                      contentPadding: const EdgeInsets.all(0.0),
                      title: Text(
                        'Log Out',
                        style: AppTextStyles.labelMedium(context),
                      ),
                      trailing: const Icon(
                        Icons.logout_rounded,
                        size: 20.0,
                      ),
                    ),
                  ),
                ],
                child: SizedBox(
                  width: 30,
                  height: 30,
                  child: Center(
                    child: Text(
                      'MM',
                      style: AppTextStyles.titleSmall(context).copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void onSelected(BuildContext context, int item) {
    switch (item) {
      case 0:
        Provider.of<DriverInfoProvider>(context, listen: false).clearDriver();
        context.goNamed(AppRoutes.login);
        break;
      case 1:
        // Acción para la opción 2
        break;
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
